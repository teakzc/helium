---
# https://vitepress.dev/reference/default-theme-home-page
layout: home

hero:
  name: "Helium"
  text: "the framework to elevate your games"
  tagline: "Remove the hassle of creating games; Helium takes care of the dirty work. In other words: unparalleled DX."
  image:
    src: /assets/helium.svg
    alt: Helium logo
  actions:
    - theme: brand
      text: Get Started
      link: /gettingstarted/introduction
    - theme: alt
      text: API
      link: /api-examples

features:
  - title: Datastores?
    icon: 🗃️
    details: Easily manage player's data using a wrapper of Lyra by paradoxum games.
  - title: UI?
    icon: 💻
    details: Use a custom Fusion wrapper with charm integration to make writing UI an absolute joy. You can use the premade theme or make your own.
  - title: Networking & Replication?
    icon: ⚡
    details: Helium uses charm-sync where you can use your own custom serdes to easily replicate player data and states. For networking, that's for you to decide!
  - title: Player state management?
    icon: ⚛️
    details: Effortlessly manage player states via charm by littensy. Helium gives you a minimal system to easily work with.
---