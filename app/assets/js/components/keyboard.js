const keyboard = function () {
  return {
    ready: false,
    display: "letters",
    height: 0,
    actionButtons: [],

    init() {
      this.$nextTick(() => {
        this.ready = true;

        this.actionButtons = Array.from(this.$root.querySelectorAll(".keyboard-action")).map(
          (action) => Alpine.$data(action)
        );

        setTimeout(() => this.setHeight());
      });
    },

    resetActions() {
      this.actionButtons.forEach((action) => action.reset());
    },

    setHeight() {
      if (this.ready) {
        this.display = "letters";
        this.$nextTick(() => {
          this.height = this.$refs.letters.offsetHeight;
        });
      }
    },

    keypress(key) {
      this.$dispatch("keyboard:input", { key });
    },

    toggleDisplay() {
      this.display = this.letters ? "actions" : "letters";
    },

    get letters() {
      return this.display === "letters";
    },

    get actions() {
      return this.display === "actions";
    },
  };
};

export { keyboard };
