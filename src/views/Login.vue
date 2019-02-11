<template>
  <div>

    <d-container fluid class="main-content-container px-4">
      <d-row>
        <d-col lg="5" class="mb-4 mx-auto mt-5 pt-5">
          <d-card class="card-small mb-4">
            <d-card-header class="border-bottom">
              <h6 class="m-0">Login</h6>
            </d-card-header>
            <d-list-group flush>
              <d-list-group-item class="p-3">
                <d-row>
                  <d-col sm="12">
                    <d-form @submit.prevent="handleLogin">
                      <div class="form-group">
                        <!-- <d-input-group prepend="@" class="mb-3">
                          <d-input placeholder="Email address" v-model="email" />
                        </d-input-group> -->
                        <d-input-group seamless class="mb-3">
                          <d-input type="text" value="" v-model="email" placeholder="Email address" required />
                          <d-input-group-text slot="append">
                            @
                          </d-input-group-text>
                        </d-input-group>
                      </div>
                      <div class="form-group">

                        <d-input-group seamless class="mb-3">
                          <d-input type="password" value="" v-model="password" placeholder="Password" />
                          <d-input-group-text slot="append">
                            <i class="material-icons">lock</i>
                          </d-input-group-text>
                        </d-input-group>

                        <!-- <d-input-group prepend="#" class="mb-3">
                          <d-input type="password" placeholder="Password" value="" v-model="password" />
                        </d-input-group> -->
                      </div>
                      <d-button type="submit" class="btn-accent">Login</d-button>
                    </d-form>
                  </d-col>
                </d-row>
              </d-list-group-item>
            </d-list-group>
          </d-card>
        </d-col>
      </d-row>
    </d-container>
  </div>
</template>

<script>
import invoicerApi from "../utils/InvoicerApi";
export default {
  components: {},
  data() {
    return {
      email: "",
      password: ""
    };
  },
  methods: {
    handleLogin() {
      console.log(`${this.email} : ${this.password}`);
      invoicerApi.post("/login", {
        email: this.email,
        password: this.password
      }).then((response) => {
        console.log(response.data);
        window.localStorage.setItem("jwt", response.data.jwt);
        this.$router.push("blog-overview");
      }).catch((error) => {
        console.log(error);
      });
    }
  },
  computed: {
    smallStats() {
      return [{
        label: 'Posts',
        value: '2,390',
        percentage: '4.7%',
        increase: true,
        labels: ['Label', 'Label', 'Label', 'Label', 'Label', 'Label'],
        datasets: [{
          label: 'Today',
          fill: 'start',
          borderWidth: 1.5,
          backgroundColor: 'rgba(0, 184, 216, 0.1)',
          borderColor: 'rgb(0, 184, 216)',
          data: [1, 2, 1, 3, 5, 4, 7],
        }],
      }, {
        label: 'Pages',
        value: '182',
        percentage: '12.4',
        increase: true,
        labels: ['Label', 'Label', 'Label', 'Label', 'Label', 'Label'],
        datasets: [{
          label: 'Today',
          fill: 'start',
          borderWidth: 1.5,
          backgroundColor: 'rgba(23,198,113,0.1)',
          borderColor: 'rgb(23,198,113)',
          data: [1, 2, 3, 3, 3, 4, 4],
        }],
      }, {
        label: 'Comments',
        value: '8,147',
        percentage: '3.8%',
        increase: false,
        decrease: true,
        labels: ['Label', 'Label', 'Label', 'Label', 'Label', 'Label'],
        datasets: [{
          label: 'Today',
          fill: 'start',
          borderWidth: 1.5,
          backgroundColor: 'rgba(255,180,0,0.1)',
          borderColor: 'rgb(255,180,0)',
          data: [2, 3, 3, 3, 4, 3, 3],
        }],
      }, {
        label: 'New Customers',
        value: '29',
        percentage: '2.71%',
        increase: false,
        decrease: true,
        labels: ['Label', 'Label', 'Label', 'Label', 'Label', 'Label'],
        datasets: [{
          label: 'Today',
          fill: 'start',
          borderWidth: 1.5,
          backgroundColor: 'rgba(255,65,105,0.1)',
          borderColor: 'rgb(255,65,105)',
          data: [1, 7, 1, 3, 1, 4, 8],
        }],
      }, {
        label: 'Subscribers',
        value: '17,281',
        percentage: '2.4%',
        increase: false,
        decrease: true,
        labels: ['Label', 'Label', 'Label', 'Label', 'Label', 'Label'],
        datasets: [{
          label: 'Today',
          fill: 'start',
          borderWidth: 1.5,
          backgroundColor: 'rgb(0,123,255,0.1)',
          borderColor: 'rgb(0,123,255)',
          data: [3, 2, 3, 2, 4, 5, 4],
        }],
      }];
    },
  },
};
</script>

