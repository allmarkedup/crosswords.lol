import { fireConfetti } from "../helpers/confetti";

export default function Puzzle({ id, entries }) {
  let vibeTimer = null;

  return {
    entries: entries,
    state: null,
    vibing: false,
    finished: false,
    summary: false,
    $puzzle: null,

    init() {
      this.$puzzle = this;
      this.state = this.getState(id);

      this.$app.modal = this.finished ? "summary" : null;

      this.$watch("state.values", () => {
        this.state.updated_at = Date.now();
      });
    },

    getState(id) {
      if (!this.$state.crosswords[id]?.values) {
        this.$state.crosswords[id] = {
          activeEntryId: this.entries[0].id,
          activeCellId: null,
          timer: null,
          values: {},
          events: [],
          updated_at: Date.now(),
        };
      }
      return this.$state.crosswords[id];
    },

    markComplete({ detail }) {
      if (!detail.initial) {
        this.celebrate();
      }
      this.finished = true;
      this.$app.modal = "summary";
    },

    markIncomplete() {
      this.finished = false;
      this.$app.modal = null;
    },

    record(name, detail = {}) {
      if (!Array.isArray(this.state.events)) {
        this.state.events = [];
      }
      this.state.events.push(detail ? { name, detail } : name);
    },

    reset() {
      this.state.events = [];
      this.finished = false;
      this.$app.modal = null;
    },

    celebrate() {
      fireConfetti();

      this.vibing = true;
      vibeTimer = setTimeout(() => {
        this.vibing = false;
      }, 7000);
    },

    destroy() {
      clearTimeout(vibeTimer);
    },
  };
}
