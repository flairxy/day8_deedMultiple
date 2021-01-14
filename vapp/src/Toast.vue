<template>
  <div></div>
</template>
<script>
import Toasted from "vue-toasted";
import Vue from "vue";
Vue.use(Toasted);
export default {
  mounted() {
    const contractEventHandler = ({ contractName, eventName, data }) => {
      const display = `${contractName}(${eventName}): ${data._message}}`;
      // const display = `${contractName}(${eventName}): ${data.newValue}, ${data.date}`;
      const subOption = { duration: 3000 };
      this.$toasted.show(display, subOption);
    };
    this.$drizzleEvents.$on("drizzle/contractEvent", (payload) => {
      contractEventHandler(payload);
    });
  },
};
</script>
