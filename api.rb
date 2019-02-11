require "sinatra"
require "sinatra/cross_origin"
require "jwt"

require "pry"

INVOICES = [
  {
    id: 1,
    number: "01/2018-19",
    issue_date: Time.parse("2019-02-03"),
    payment_deadline: Time.parse("2019-02-15"),
    paid: true,
    issuer: {
      name: "Aurantium Ltd",
      address: "The Apex, 2 Sherriff Orchard, CV1 3PP Coventry",
      company_number: "07976765",
      vat_number: nil
    },
    client: {
      name: "Big Sofa Technologies Limited",
      address: "Finsgate, 5-7 Cranwood Street, EC1V 9EE, London",
      company_number: "08687045"
    },
    line_items: [{
      name: "Software Development Services in January",
      symbol: "",
      unit: "",
      quantity: 22,
      net_price: 500,
      taxes: [{
        name: "VAT",
        rate: 0.2
      }]
    }]
  },
  {
    id: 2,
    number: "02/2018-19",
    issue_date: Time.parse("2019-02-03"),
    payment_deadline: Time.parse("2019-02-15"),
    paid: true,
    issuer: {
      name: "Aurantium Ltd",
      address: "The Apex, 2 Sherriff Orchard, CV1 3PP Coventry",
      company_number: "07976765",
      vat_number: nil
    },
    client: {
      name: "Big Sofa Technologies Limited",
      address: "Finsgate, 5-7 Cranwood Street, EC1V 9EE, London",
      company_number: "08687045"
    },
    line_items: [{
      name: "Software Development Services in January",
      symbol: "",
      unit: "",
      quantity: 22,
      net_price: 500,
      taxes: [{
        name: "VAT",
        rate: 0.2
      }]
    }]
  }
]

class JwtEncoder
  HMAC_SECRET = "secret"
  def self.call(user)
    exp = Time.now.to_i + 4 * 3600
    exp_payload = { data: user, exp: exp }

    JWT.encode(exp_payload, HMAC_SECRET, "HS256")
  end
end

class JwtDecoder
  HMAC_SECRET = "secret"
  def self.call(token)
    begin
      JWT.decode(token, HMAC_SECRET, true, { algorithm: "HS256" }).first["data"]
    rescue JWT::ExpiredSignature
      # Handle expired token, e.g. logout user or deny access
      raise "Unauthorized"
    end
  end
end

set :bind, "0.0.0.0"

configure do
  enable :cross_origin
end

before do
  response.headers["Access-Control-Allow-Origin"] = "*"
end

# routes...
options "*" do
  response.headers["Allow"] = "GET, POST, OPTIONS"
  response.headers["Access-Control-Allow-Headers"] = "Authorization, Content-Type, Accept, X-User-Email, X-Auth-Token"
  response.headers["Access-Control-Allow-Origin"] = "*"
  200
end

get "/user_data" do
  jwt = request.env["HTTP_AUTHORIZATION"].split("Bearer ").last
  JwtDecoder.call(jwt).to_json
end

post "/login" do
  body = request.body.read
  params = JSON.parse(body)
  if params["email"] == "krzyczak@gmail.com" && params["password"] == "qweqwe"
    { jwt: JwtEncoder.call(params.slice("email")) }.to_json
  else
    status 404
    body({ message: "Not found" }.to_json)
  end
end


get "/invoices" do
  jwt = request.env["HTTP_AUTHORIZATION"].split("Bearer ").last
  user_data = JwtDecoder.call(jwt).to_json

  # current_user = User.find_by(email: user_data["email"])
  # current_user.invoices.to_json

  INVOICES.to_json
end

get "/invoices/:id" do
  jwt = request.env["HTTP_AUTHORIZATION"].split("Bearer ").last
  user_data = JwtDecoder.call(jwt).to_json

  # body = request.body.read
  # params = JSON.parse(body)

  INVOICES.group_by { |inv| inv[:id] }.transform_keys(&:to_s)[params["id"]][0].to_json
end
