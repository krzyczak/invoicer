<template>
  <div>
    <vue-json-pretty
      :path="'res'"
      :data="invoice"
      @click="getInvoice">
    </vue-json-pretty>
  </div>
</template>

<script>
import invoicerApi from "../utils/InvoicerApi";
export default {
  components: {},
  data() {
    return {
      invoice: {}
    };
  },
  methods: {
    getInvoice() {
      invoicerApi.get(`/invoices/${this.$route.params.id}`).then((response) => {
        this.invoice = response.data;
      }).catch((error) => {
        this.$router.push({ name: "login" })
      });
    }
  },
  computed: {},
  mounted() {
    this.getInvoice();
  }
};
</script>

