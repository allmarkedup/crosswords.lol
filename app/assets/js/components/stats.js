import { timerText } from "../helpers/misc";

export default function Stats() {
  return {
    getEvents(name) {
      return this.$puzzle.state.events.filter((event) => event.name === name);
    },

    get timeTaken() {
      if (this.$puzzle.state.timer?.started) {
        return timerText(this.$puzzle.state.timer?.seconds);
      } else {
        return null;
      }
    },

    get wordChecks() {
      return this.getEvents("check-word").length;
    },

    get letterReveals() {
      return this.getEvents("reveal-letter").length;
    },

    get wordReveals() {
      return this.getEvents("reveal-word").length;
    },
  };
}
