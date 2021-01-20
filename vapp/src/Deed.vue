<template>
  <div>
    <p>You can only withdraw from the account[1]</p>
    <p>Remaining Payouts: {{ 10 - paidPayouts }}</p>
    <p>Next Pay is: {{ nextTime }}</p>
    <button @click.prevent="withdrawEther">Withdraw</button>
  </div>
</template>
<script>
import { mapGetters } from "vuex";
export default {
  name: "DeedMultiPayouts",
  computed: {
    ...mapGetters("drizzle", ["drizzleInstance"]),
  },
  data: () => ({
    paidPayouts: null,
    nextTime: null,
  }),
  methods: {
    withdrawEther() {
      this.drizzleInstance.contracts.DeedMultiPayouts.methods
        .withdraw()
        .send()
        .then((res) => {
          this.getPayoutsInfo();
          this.nextPayTime();
        })
        .catch((err) => console.log(err));
    },
    getPayoutsInfo() {
      this.drizzleInstance.contracts.DeedMultiPayouts.methods
        .paidPayouts()
        .call()
        .then((paidPayouts) => {
          this.paidPayouts = `${paidPayouts}/10`;
        })
        .catch((err) => console.log(err));
    },
    nextPayTime() {
      this.drizzleInstance.contracts.DeedMultiPayouts.methods
        .earliest()
        .call()
        .then((earliest) => {
          //Returned timestamp is in second.. but Javascript timestamp are in milliseconds...
          this.nextTime = `${new Date(
            parseInt(earliest) * 1000
          ).toLocaleString()}/10`;
        });
    },
  },
  created() {
    this.getPayoutsInfo();
    this.nextPayTime();
  },
};
</script>
