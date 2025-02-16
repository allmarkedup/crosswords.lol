export default function Keyboard() {
  return {
    pane: "input",

    keypress(key) {
      this.$dispatch("keyboard:input", { key });
    },
  };
}
