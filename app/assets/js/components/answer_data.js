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

      if (answer.events.length > 0) {
        this.$puzzle.state.events = Alpine.raw(answer.events);
      }

      if (answer.timer && answer.timer.seconds > this.$puzzle.state.timer.seconds) {
        this.$puzzle.state.timer = Alpine.raw(answer.timer);
      }

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
      if (parseInt(data.initiator_id) !== this.clientId) {
        if (isDifferent(this.$puzzle.state.values, data.answer.values)) {
          this.$puzzle.state.values = data.answer.values;
        }
        this.$puzzle.state.events = data.answer.events;
        this.$puzzle.state.timer = data.answer.timer;
      }
    },

    async save() {
      if (!this.completedAt && this.$puzzle.finished) {
        this.completedAt = new Date();
      } else if (!this.$puzzle.finished) {
        this.completedAt = null;
      }

      const answerState = {
        completed_at: this.completedAt,
        events: [...Alpine.raw(this.$puzzle.state.events)],
        values: Object.assign({}, Alpine.raw(this.$puzzle.state.values)),
        timer: Object.assign({}, Alpine.raw(this.$puzzle.state.timer)),
      };

      if (isDifferent(answerState, this._lastSaved)) {
        try {
          const request = new FetchRequest("put", `/answers/${this.answerId}.json`, {
            body: {
              client_id: this.clientId,
              answer: answerState,
            },
          });

          const response = await request.perform();
          if (response.ok) {
            this._lastSaved = answerState;
          } else {
            console.error("Error saving answers", response);
          }
        } catch (e) {
          console.error(e);
        }
      }
    },

    destroy() {
      return this.save();
    },
  };
}

function isDifferent(obj1, obj2) {
  return !isEqual(Alpine.raw(obj1), Alpine.raw(obj2));
}
