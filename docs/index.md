---
# https://vitepress.dev/reference/default-theme-home-page
layout: home

hero:
  name: "Helium"
  text: "the framework template to accelerate your game production"
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
  - title: Template?
    icon: 🤨
    details: Helium is a template that you control; you create a framework that accelerates the process of creating games. Just focus on content production, while helium figures out your backend.
  - title: Datastores?
    icon: 🗃️
    details: Easily manage player's data by using a charm-sync integrated wrapper of Lyra, a datastore library by paradoxum games.
  - title: UI?
    icon: 💻
    details: Use a custom Fusion wrapper with charm-sync integration to make writing UI an absolute joy. You can use the premade components or make your own.
  - title: State management & Replication?
    icon: ⚛️
    details: Helium uses charm & charm-sync where you can use your own custom serdes to easily read and write and also replicate player data and states.
---