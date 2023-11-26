---
layout: page
permalink: /publications/
title: publications
description: My research work publications in various conferences, journals, and blogs.
years: [2012, 2018, 2021, 2022, 2023]
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
