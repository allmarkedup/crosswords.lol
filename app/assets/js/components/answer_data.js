import { FetchRequest } from "@rails/request.js";
import { createConsumer } from "@rails/actioncable";
import isEqual from "lodash.isequal";

export default function AnswerData(answer) {
  return {
    consumer: null,
    answerId: answer.id,
    clientId: Math.floor(Math.random() * 1000000),
    completedAt: answer.completed_at ? new Date(answer.completed_at) : null,
    _lastSaved: answer.values,

    init() {
      this.updateDataReceived = this.updateDataReceived.bind(this);

      this.consumer = createConsumer();
      this.subscribeToUpdates();

      this.$puzzle.state.values = Object.assign(
        {},
        Alpine.raw(this.$puzzle.state.values),
        Alpine.raw(answer.values)
      );
      this.$nextTick(() => this.save());
    },

    subscribeToUpdates() {
      this.consumer.subscriptions.create(
        { channel: "AnswersChannel", id: answer.id },
        {
          received: this.updateDataReceived,
        }
      );
    },

    updateDataReceived(data) {
      if (
        parseInt(data.initiator_id) !== this.clientId &&
        isDifferent(this.$puzzle.state.values, data.answer.values)
      ) {
        this.$puzzle.state.values = data.answer.values;
      }
    },

    async save() {
      if (isDifferent(this.$puzzle.state.values, this._lastSaved)) {
        if (!this.completedAt && this.$puzzle.finished) {
          this.completedAt = new Date();
        } else if (!this.$puzzle.finished) {
          this.completedAt = null;
        }

        const values = Object.assign({}, Alpine.raw(this.$puzzle.state.values));

        try {
          const request = new FetchRequest("put", `/answers/${this.answerId}.json`, {
            body: {
              client_id: this.clientId,
              answer: {
                completed_at: this.completedAt,
                values: values,
              },
            },
          });

          const response = await request.perform();
          if (response.ok) {
            this._lastSaved = values;
          } else {
            console.error("Error saving answers", response);
          }
        } catch (e) {
          console.error(e);
        }
      }
    },
  };
}

function isDifferent(obj1, obj2) {
  return !isEqual(Alpine.raw(obj1), Alpine.raw(obj2));
}

function convertToDateTimeLocalString(date) {
  const year = date.getFullYear();
  const month = (date.getMonth() + 1).toString().padStart(2, "0");
  const day = date.getDate().toString().padStart(2, "0");
  const hours = date.getHours().toString().padStart(2, "0");
  const minutes = date.getMinutes().toString().padStart(2, "0");

  return `${year}-${month}-${day}T${hours}:${minutes}`;
}
