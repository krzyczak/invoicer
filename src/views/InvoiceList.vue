<template>
  <div class="main-content-container container-fluid px-4">
    <!-- Page Header -->
    <div class="page-header row no-gutters py-4">
      <div class="col-12 col-sm-4 text-center text-sm-left mb-0">
        <span class="text-uppercase page-subtitle">Invoices</span>
        <h3 class="page-title">Invoices</h3>
      </div>
    </div>

    <!-- Default Light Table -->
    <div class="row">
      <div class="col">
        <div class="card card-small mb-4">
          <div class="card-header border-bottom">
            <h6 class="m-0">Invoices</h6>
          </div>
          <div v-if="invoices.length < 1" class="card-body p-0 pb-3">
            Loading...
          </div>
          <div v-if="invoices.length > 0" class="card-body p-0 pb-3">
            <table class="table mb-0">
              <thead class="bg-light">
                <tr>
                  <th scope="col" class="border-0 text-center">#</th>
                  <th scope="col" class="border-0">Client</th>
                  <th scope="col" class="border-0">Issue Date</th>
                  <th scope="col" class="border-0">Payment Deadline</th>
                  <th scope="col" class="border-0">Net Amount</th>
                  <th scope="col" class="border-0">Gross Amount</th>
                </tr>
              </thead>
              <tbody>
                <!-- TODO: -->
                <!-- add loading state -->
                <!-- add empty state -->
                <tr v-for="invoice in invoices">
                  <td class="text-center">{{ invoice.number }}</td>
                  <td>
                    <router-link :to="{ name: 'invoice', params: { id: invoice.id }}">{{ invoice.client.name }}</router-link>
                  </td>
                  <td>{{ invoice.issue_date }}</td>
                  <td>{{ invoice.payment_deadline }}</td>
                  <td class="text-center">{{ invoice.line_items.map(item => item.quantity * item.net_price).reduce((accumulator, currentValue) => accumulator + currentValue) }}</td>
                  <td class="text-center">{{ invoice.line_items.map(item => item.quantity * item.net_price * 1.2).reduce((accumulator, currentValue) => accumulator + currentValue) }}</td>
                </tr>
              </tbody>
            </table>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import invoicerApi from "../utils/InvoicerApi";
export default {
  components: {},
  data() {
    return {
      invoices: []
    };
  },
  methods: {
    getInvoices() {
      invoicerApi.get("/invoices").then((response) => {
        this.invoices = response.data;
      }).catch((error) => {
        this.$router.push({ name: "login" })
      });
    }
  },
  computed: {},
  mounted() {
    this.getInvoices();
  }
};
</script>

