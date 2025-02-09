const timer = function (args) {
  let timerInterval = null;

  return {
    state: null,

    init() {
      const crosswordState = this.$store.state.getCrosswordState(args.id);
      if (crosswordState.timer === null) {
        crosswordState.timer = { running: false, seconds: 0, started: false };
      }
      this.state = crosswordState.timer;
      this.puzzleTimer = this;

      timerInterval = setInterval(() => {
        if (this.running && this.puzzleHasFocus && this.timeElapsed < 86400) {
          this.timeElapsed = this.timeElapsed + 1;
        }
      }, 1000);
    },

    start() {
      this.running = true;
      this.state.started = true;
    },

    stop() {
      this.running = false;
    },

    toggle() {
      console.log(this.running);
      this.running ? this.stop() : this.start();
      console.log(this.running);
    },

    reset() {
      this.timeElapsed = 0;
    },

    destroy() {
      clearInterval(timerInterval);
    },

    get timeElapsed() {
      return this.state.seconds;
    },

    set timeElapsed(value) {
      this.state.seconds = value;
    },

    get running() {
      return this.state.running;
    },

    set running(value) {
      this.state.running = value;
    },

    get started() {
      return this.state.started;
    },

    get stopped() {
      return !this.running;
    },

    get formattedTimeElapsed() {
      return timerText(this.timeElapsed);
    },
  };
};

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

export { timer };
