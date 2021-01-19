<template>
  <div>
    <p>You can only withdraw from the account[1]</p>
    <button @click.prevent="withdrawEther">Withdraw</button>
  </div>
</template>
<script>
import { mapGetters } from "vuex";
export default {
  name: "Deed",
  computed: {
    ...mapGetters("drizzle", ["drizzleInstance"]),
  },
  methods: {
    withdrawEther() {
      this.drizzleInstance.contracts.Deed.methods
        .withdraw()
        .send()
        .then((res) => console.log(res))
        .catch((err) => console.log(err));
    },
  },
};
</script>
