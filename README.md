# ContractManager

UI Demo [link](http://recordit.co/lvZQKHlBGa) There is some info's like date, to, from for a transaction etc which I have not displayed so far as I was mostly interested in status of the transaction. This is something I was planning to work on but didn't get time.

Setup and Configs:
  * clone the repo from bitbucket
    ```
    $ git clone git@bitbucket.org:pkrawat1/ct_man.git
    ```
  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.create && mix ecto.migrate`
  * Seed Data
    ```
    $ mix run priv/repo/seeds.exs
    ```
  * Install React dependency
    ```
    $ cd assets
    $ yarn install
    ```
  * Run the Phoenix server from root folder: `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.


