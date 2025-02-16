const settings = {
  timer: false,
};

const state = {
  crosswords: {},
};

let focusWatcher = null;

export default function App() {
  return {
    $app: null,
    $settings: Alpine.$persist(settings).as("settings"),
    $state: Alpine.$persist(state).as("state"),

    hasFocus: true,
    screen: "puzzle",

    init() {
      this.$app = this;

      focusWatcher = setInterval(() => {
        this.hasFocus = document.hasFocus();
      }, 200);
    },

    destroy() {
      clearInterval(focusWatcher);
    },
  };
}
