export default function Modal() {
  return {
    id: null,

    init() {
      this.id = this.$el.id;
    },

    show() {
      console.log("show", this.id, this.$app.modal);
      this.$app.modal = this.id;
    },

    hide() {
      this.$app.modal = null;
    },
  };
}
