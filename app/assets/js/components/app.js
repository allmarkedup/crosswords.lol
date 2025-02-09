const app = function () {
  return {
    screen: "puzzle",
    settings: this.$store.state.settings,

    init() {},

    showSettings() {
      this.screen = "settings";
    },

    hideSettings() {
      this.screen = "puzzle";
    },

    get puzzleScreen() {
      return this.screen === "puzzle";
    },

    get settingsScreen() {
      return this.screen === "settings";
    },
  };
};

export { app };
