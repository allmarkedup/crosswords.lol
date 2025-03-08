import { FetchRequest } from "@rails/request.js";
import { getFormData } from "../helpers/misc";

export default function AnswerData(answer) {
  return {
    init() {
      this.$watch(
        "answerDataJSON",
        Alpine.debounce(() => this.save(), 300)
      );

      if (answer.synced_at) {
        this.$puzzle.state.values = Object.assign({}, this.$puzzle.state.values, answer.values);
      }
    },

    async save() {
      try {
        const request = new FetchRequest(this.form.method, `${this.form.action}.json`, {
          body: new FormData(this.form),
        });

        const response = await request.perform();
        if (!response.ok) {
          console.error("Error saving answers", response);
        }
      } catch (e) {
        console.error(e);
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
