import { FetchRequest } from "@rails/request.js";
import { createConsumer } from "@rails/actioncable";
import isEqual from "lodash.isequal";

export default function AnswerData(answer) {
  return {
    consumer: null,
    clientId: Math.floor(Math.random() * 1000000),
    updating: false,
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
        isDifferent(this.$puzzle.state.values, data.answer.values) &&
        !this.updating
      ) {
        this.$puzzle.state.values = data.answer.values;
      }
    },

    async save() {
      if (isDifferent(this.$puzzle.state.values, this._lastSaved)) {
        console.log("save");
        try {
          const request = new FetchRequest(this.form.method, `${this.form.action}.json`, {
            body: new FormData(this.form),
          });

          const response = await request.perform();
          if (response.ok) {
            this._lastSaved = Object.assign({}, Alpine.raw(this.$puzzle.state.values));
          } else {
            console.error("Error saving answers", response);
          }
        } catch (e) {
          console.error(e);
        }
      }
    },

    get form() {
      return this.$refs.answerForm;
    },

    get answerDataJSON() {
      const values = Object.fromEntries(
        Object.entries(this.$puzzle.state.values).filter(([_, v]) => v !== "")
      );
      return JSON.stringify(values);
    },
  };
}

function isDifferent(obj1, obj2) {
  return !isEqual(Alpine.raw(obj1), Alpine.raw(obj2));
}
