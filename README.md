# Accounting application

This  is a [Sails](http://sailsjs.org) application designed perferrably for small-scale enterprises or businesses (ex.: Sari2x stores, small groceries) to facilitate in accounting their transactions, profits, etc.

It provides the basic features needed for accounting and is currently under development and subject for comments/improvements.

It currently features a set of tools namely:

* Dashboard(under development) - View reports/graphs/summaries.
* Inventory(under development) - Track inventory.
* Unit - Manage product units.
* Price List - Manage prices.
* Transaction - Input/output of items.


## Setup

The repository is available at https://github.com/wkhu/accounting.git

```
git clone https://github.com/wkhu/accounting.git
```
After you've cloned the app, first thing you'll need to do is open the terminal and navigate to the inside of your cloned repository.

Since this project was made using an old version of Sails, it is recommended to install NVM to facilitate changing to the necessary node version for it to run properly.

To **install** or **update** nvm, you can use the [install script][2] using cURL:

```sh
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.34.0/install.sh | bash
```

or Wget:

```sh
wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.34.0/install.sh | bash
```

<sub>The script clones the nvm repository to `~/.nvm` and adds the source line to your profile (`~/.bash_profile`, `~/.zshrc`, `~/.profile`, or `~/.bashrc`).</sub>

<sub>**Note:** If the environment variable `$XDG_CONFIG_HOME` is present, it will place the `nvm` files there.</sub>

```sh
export NVM_DIR="${XDG_CONFIG_HOME/:-$HOME/.}nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
```

**Note:** You can add `--no-use` to the end of the above script (...`nvm.sh --no-use`) to postpone using `nvm` until you manually [`use`](#usage) it.

You can customize the install source, directory, profile, and version using the `NVM_SOURCE`, `NVM_DIR`, `PROFILE`, and `NODE_VERSION` variables.
Eg: `curl ... | NVM_DIR="path/to/nvm"`. Ensure that the `NVM_DIR` does not contain a trailing slash.

<sub>*NB. The installer can use `git`, `curl`, or `wget` to download `nvm`, whatever is available.*</sub>

**Note:** On Linux, after running the install script, if you get `nvm: command not found` or see no feedback from your terminal after you type:

```sh
command -v nvm
```

Simply close your current terminal, open a new terminal, and try verifying again.

When NVM is set, use node version v5.10.1

```
nvm use v5.10.1
```

You can then use npm to install all necessary dependencies.

```
npm install
```

To run the app in the default port 1338 run this command in the terminal.

```
sails lift
```

Or instead of sails lift, you may also use nodemon which is a utility that will monitor for any changes in your source and automatically restart your server. Install it using npm.

```
npm install -g nodemon
```

Then start the server with

```
nodemon app.js
```
