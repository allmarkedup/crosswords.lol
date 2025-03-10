import { timerText } from "../helpers/misc";

export default function Timer() {
  let timerInterval = null;

  return {
    init() {
      if (this.$puzzle.state.timer === null) {
        this.$puzzle.state.timer = { running: false, seconds: 0, started: false };
      }

      timerInterval = setInterval(() => {
        if (this.running && this.$app.hasFocus && this.timeElapsed < 86400) {
          this.timeElapsed = this.timeElapsed + 1;
        }
      }, 1000);
    },

    start() {
      this.running = true;
      this.$puzzle.state.timer.started = true;
      this.$dispatch("timer:change");
    },

    stop(silent = false) {
      this.running = false;
      if (!silent) this.$dispatch("timer:change");
    },

    toggle() {
      this.running ? this.stop() : this.start();
    },

    reset() {
      this.stop(true);
      this.$puzzle.state.timer.started = false;
      this.timeElapsed = 0;
      this.$dispatch("timer:change");
    },

    destroy() {
      clearInterval(timerInterval);
    },

    get timeElapsed() {
      return this.$puzzle.state.timer.seconds;
    },

    set timeElapsed(value) {
      this.$puzzle.state.timer.seconds = value;
    },

    get running() {
      return this.$puzzle.state.timer.running;
    },

    set running(value) {
      this.$puzzle.state.timer.running = value;
    },

    get started() {
      return this.$puzzle.state.timer.started;
    },

    get stopped() {
      return !this.running;
    },

    get formattedTimeElapsed() {
      return timerText(this.timeElapsed);
    },
  };
}
