import { timerText } from "../helpers/misc";

export default function Stats() {
  return {
    getEvents(name) {
      return this.events.filter((event) => event.name === name);
    },

    hasEvent(name) {
      return !!this.events.find((event) => event.name === name);
    },

    get events() {
      return this.$puzzle.state.events.map((evt) => {
        return typeof evt === "string" ? { name: evt } : evt;
      });
    },

    get timeTaken() {
      if (this.$puzzle.state.timer?.started) {
        return timerText(this.$puzzle.state.timer?.seconds);
      } else {
        return null;
      }
    },

    get wordChecks() {
      return this.getEvents("cw").length;
    },

    get checkAlls() {
      return this.getEvents("ca").length;
    },

    get letterReveals() {
      return this.getEvents("rl").length;
    },

    get wordReveals() {
      return this.getEvents("rw").length;
    },

    get revealedAll() {
      return this.hasEvent("ra");
    },
  };
}
