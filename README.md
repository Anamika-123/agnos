# README

Rails version should be `7.0.6`

Ruby version should be `3.0.1`

## Database Specifications
Use PostgreSQL for database

## Project Setup

rvm use `ruby use 3.0.1` or `rbenv local 3.0.1`

`bundle install`

`rake db:reset`

`rails s`




## User endpoints

#### For signup
Sample request

method -> POST
url -> `http://localhost:3000/api/signup`
params -> user[email] user[password]

`Sample response`

{
    "id": 3,
    "email": "abcd@gmail.com",
    "created_at": "2023-07-12T08:15:28.187Z",
    "updated_at": "2023-07-12T08:15:28.187Z"
}

#### For Login
`Sample request` 

method -> POST
url -> `http://localhost:3000/api/login`
params -> `email, password`

`This api request generates token to validate further requests`

`Sample response`

{
    "token": "eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjozfQ.q5rnRkvH8YAQJFdMcr9YUhcVfLaPNk1vk7D-daZZJmg",
    "user": {
        "id": 3,
        "email": "abcd@gmail.com",
        "created_at": "2023-07-12T08:15:28.187Z",
        "updated_at": "2023-07-12T08:15:28.187Z"
    }
}

### For product

#### Create product

`Sample request`

method -> POST
url -> `http://localhost:3000/api/products`
params -> `product[name] product[price] product[tax_percentage]`
Headers -> `{{X-Auth-Token}}`

`Sample response`

{
    "id": 2,
    "name": "Tea",
    "price": "50.0",
    "tax_percentage": "10.0",
    "created_at": "2023-07-12T08:25:49.711Z",
    "updated_at": "2023-07-12T08:25:49.711Z"
}


#### List products

`Sample request`

method -> GET
url -> `http://localhost:3000/api/products`
Headers -> `{{X-Auth-Token}}`

`Sample response`

[
    {
        "id": 1,
        "name": "coffee",
        "price": "100.0",
        "tax_percentage": "4.0",
        "created_at": "2023-07-12T08:22:12.502Z",
        "updated_at": "2023-07-12T08:22:12.502Z"
    },
    {
        "id": 2,
        "name": "Tea",
        "price": "50.0",
        "tax_percentage": "10.0",
        "created_at": "2023-07-12T08:25:49.711Z",
        "updated_at": "2023-07-12T08:25:49.711Z"
    }
]


### Create order item

`Sample request`

method -> POST
url -> `http://localhost:3000/api/order_items`
params -> `product_id`
Headers -> `{{X-Auth-Token}}`

`Sample response`

{
    "id": 16,
    "product_id": 1,
    "order_id": 8,
    "price": "100.0",
    "quantity": 1,
    "tax": "4.0",
    "created_at": "2023-07-12T12:29:58.784Z",
    "updated_at": "2023-07-12T12:29:58.784Z"
}


### Update order item

`Sample request`

method -> PATCH
url -> `http://localhost:3000/api/order_items/11`
params -> `quantity`
Headers -> `{{X-Auth-Token}}`

`Sample response`

{
    "order_id": 6,
    "price": "50.0",
    "quantity": 2,
    "tax": "10.0",
    "id": 11,
    "product_id": 2,
    "created_at": "2023-07-12T12:12:52.838Z",
    "updated_at": "2023-07-12T12:13:28.719Z"
}

### Delete order Item

`Sample request`

method -> DELETE
url -> `http://localhost:3000//api/order_items/1`
Headers -> `{{X-Auth-Token}}`

`Sample response`
  `status: 200 OK`

### Get cart

`Sample request`

method -> GET
url -> `http://localhost:3000//api/cart`
Headers -> `{{X-Auth-Token}}`

`Sample response`

{
    "items": [
        {
            "id": 15,
            "product_id": 2,
            "order_id": 8,
            "price": "50.0",
            "quantity": 1,
            "tax": "5.0",
            "created_at": "2023-07-12T12:29:55.549Z",
            "updated_at": "2023-07-12T12:29:55.549Z"
        },
        {
            "id": 16,
            "product_id": 1,
            "order_id": 8,
            "price": "100.0",
            "quantity": 1,
            "tax": "4.0",
            "created_at": "2023-07-12T12:29:58.784Z",
            "updated_at": "2023-07-12T12:29:58.784Z"
        }
    ],
    "id": 8,
    "user_id": 3,
    "status": "cart",
    "item_total": "150.0",
    "tax_amount": "9.0",
    "promotional_amount": "10.0",
    "final_amount": "149.0",
    "created_at": "2023-07-12T12:29:51.010Z",
    "updated_at": "2023-07-12T12:29:58.806Z"
}

### Place order

`Sample request`

method -> PATCH
url -> `http://localhost:3000/api/order/complete`
Headers -> `{{X-Auth-Token}}`

`Sample response`

{
    "message": "Your order was successfully placed"
}

### Create System promotion

`Sample request`

method -> POST
url -> `http://localhost:3000/api/promotions`

params -> `promotion[type] promotion[product_id] promotion[discounted_product_id] promotion[discount] promotion[active] promotion[system] promotion[discount_type]`

Headers -> `{{X-Auth-Token}}`

`Sample response`

{
    "id": 1,
    "active": true,
    "system": true,
    "discount": "10.0",
    "discount_type": "flat",
    "rule": "order_items.where(product_id: [1, 2]).count == 2\n",
    "created_at": "2023-07-12T08:57:44.780Z",
    "updated_at": "2023-07-12T08:57:44.780Z"
}

