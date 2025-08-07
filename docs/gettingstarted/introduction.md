# Introduction

Helium is template for a framework, that does your UI, datastores, state management and replication while being flexible.

## What does helium do for you?

### 😄 Convenience

Helium is a template with systems to work with [Charm](https://github.com/littensy/charm), [Fusion](https://github.com/dphfox/Fusion) and [Lyra](https://github.com/paradoxum-games/lyra) for you. You focus on creating your game while helium helps you manage with provided tools. Essentially helium facilitates a system of using Charm and Lyra and Fusion to make a barebones structure for any game which you can also choose to modify.

::: info 💡 TL;DR
instead of creating a game by yourself and setting up datastores, replication and more helium gives you a template to work with.
:::

### 🐍 Flexibility

You can still use your own functions instead of the ones helium provides. Helium also doesn't force you to do anything just to use it. Remember convience is the priority of helium.

### 🗃️ Datastores, State Management, Replication and UI

Helium has a internalized system where it asks you to create a `Store` (Lyra). This is now the source of truth of player data which is stored in a `Atom` (charm). This `Atom` stores all player data and also states (which you can read and write) which is then replicated to all clients too. This is also tied with the UI that is synced with the `Atom`'s state that helium allows you to create easily.

## 🚫 What does helium not do for you?

Helium does not do your networking! This is so you can use anything you are comfortable with and this is also the same thing with charm-sync replication. You have to set that up because then you will need to be forced to follow helium's networking system (which is not added in).