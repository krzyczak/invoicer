import axios from "axios";

const Authorization = `Bearer ${window.localStorage.getItem("jwt")}`;

const invoicerApi = axios.create({
  baseURL: "http://localhost:4567", // process.env.BASE_URL
  headers: { "Authorization": Authorization },
});

export default invoicerApi;
