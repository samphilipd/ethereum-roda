Applied Blockchain Ruby Test #1

Develop a ruby web app based on the Roda framework which has two routes that save data in a Sqlite database using the Sequel gem.

Please deliver a zip file containing the app with the data included (sqlite database file) or in a public github repository (without mentioning Applied Blockchain so we can reuse this test in the future)

Please provide curl commands to invoke the two routes via shell (written in the Readme.md file or as shell scripts in the repo/zip).

The app will be just a one time "snapshot" of multiple ethereum accounts with their addresses and their balances. You'll need to create an "accounts" table in sqlite and use Sequel to fill it with data, the only required columns are the (ethereum) account_number/address (however you want to call it) and the account balance.

The two web requests should behave as following:

GET request
Responds with a JSON list of all the accounts and balances retrieved from the database.
POST request
Accepts a parameter, address. Fetches the ethereum account/address balance from the external API and saves it to the database.
An external API to get the ethereum balances is this one: GET https://etherchain.org/api/account/0x12345...

An example call is https://etherchain.org/api/account/0x5f862a4adfc4ef14e6c6ee1acaf4838e2a0d34ad which returns an address with balance 2000000000000000000.

( example: curl https://etherchain.org/api/account/0x5f862a4adfc4ef14e6c6ee1acaf4838e2a0d34ad )

Other accounts/ethereum-addresses you can add to the database are:

0x2b9c4e2ad6f1e7bd43365abb99faa1867706ea9c
0xe0498570303d14456c71eb7f6f057ea149a425c6
0x8eeec35015baba2890e714e052dfbe73f4b752f9
0xfb663039763f61506f66158720f72794eddb1cc0

and you can pick more from here if you want/need: https://etherscan.io/accounts/47?sort=txcount&order=asc

In your POST request, your app will need to perform a web request to get the ethereum address/account balance and create a new account in the sqlite database (acounts table) to save its balance amount (as integer).

You can use any library to perform the HTTP requests and to parse the json response.

There is no time limit but it shouldn't take you probably more than 2 hours to complete the test. There is no need to write specs (as long as the two curl script work) but if you do, we'll appreciate it.

Note that the API will return the balance in Wei and 1 Ether == 1000000000000000000 Weis, you should respond with the value in wei (as the etherchain API is giving the value to you) but as a plus you could also provide in the GET response of your api the value in Ethers - here's a conversion tool: http://ether.fund/tool/converter .
