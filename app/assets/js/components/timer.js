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
    },

    stop() {
      this.running = false;
    },

    toggle() {
      this.running ? this.stop() : this.start();
    },

    reset() {
      this.stop();
      this.$puzzle.state.timer.started = false;
      this.timeElapsed = 0;
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

function timerText(seconds) {
  const elapsed = seconds * 1000;
  let h = "00",
    m = "00",
    s = "00";

  if (elapsed >= 1000) {
    s = Math.floor(elapsed / 1000);
    s = s > 60 ? s % 60 : s;
    s = leftPad(s);
  }

  if (elapsed > 60000) {
    m = Math.floor(elapsed / 60000);
    m = m > 60 ? m % 60 : leftPad(m);
  }

  if (elapsed > 3600000) {
    h = Math.floor(elapsed / 3600000);
    h = leftPad(h);
  }

  return [h, m, s].join(":");
}

function leftPad(val) {
  return val < 10 ? "0" + String(val) : val;
}
