---
layout: page
permalink: /publications/
title: publications
description: My research work publications in various conferences, journals, and blogs.
years: [2025, 2024, 2023, 2022, 2020, 2018, 2012]
nav: true
nav_order: 1
---
<!-- _pages/publications.md -->
<div class="publications">

{%- for y in page.years | reverse -%}
  <h2 class="year">{{y}}</h2>
  {% bibliography -f papers -q @*[year={{y}}]* %}
{% endfor %}

</div>
