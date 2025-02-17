export default function LoadingBar() {
  return {
    state: "inactive",
    progress: 0,

    init() {
      this.$watch("$app.loading", (loading, wasLoading) => {
        if (loading && !wasLoading) {
          this.start();
        } else if (!loading && wasLoading) {
          this.end();
        }
      });
    },

    start() {
      this.state = "loading";
      this.progress = Math.floor(Math.random() * (70 - 30 + 1) + 30);
    },

    end() {
      this.state = "complete";
      this.progress = 100;
      setTimeout(() => {
        this.state = "inactive";
        this.progress = 0;
      }, 200);
    },
  };
}
