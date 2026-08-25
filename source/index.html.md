---
title: Ezus API Reference

language_tabs: # must be one of https://github.com/rouge-ruby/rouge/wiki/List-of-supported-languages-and-lexers
  - shell: cURL
  - javascript

toc_footers:
  - <a href='https://ezus.io/' target="_blank">Documentation Powered by Ezus</a>

includes:
  - authentication
  - projects
  - travellers
  - clients
  - suppliers
  - products
  - packages
  - categories
  - destinations
  - invoices
  - deposits
  - tags
  - media
  - webhooks
  - nested_resources
  - events
  - filtering
  - date_format
  - rate_limits
  - warnings
  - errors


search: true

code_clipboard: true

meta:
  - name: description
    content: Documentation for the Ezus API
---

# Introduction

Welcome to the Ezus API. Our API follows <a href='https://en.wikipedia.org/wiki/Representational_state_transfer' target="_blank">REST</a> principles, offering a set of HTTP methods that serve as the foundation for Ezus' core functionalities. Its primary purpose is to empower you to programmatically manage your Ezus projects, clients, catalog (suppliers, products, packages), and invoices.

If you're seeking an overview of common use cases achievable through our API, feel free to explore our help center's <a href='https://help.ezus.io/en/collections/3016686-integrations' target="_blank">Integrations</a> section for valuable insights.

For those ready to delve into the details of available methods, you're in the right place. This documentation presents a technical reference for each method in the left-hand section, complemented by code examples in the right-hand section.

While each method possesses its unique specifications, here are some general guidelines:

For any request, you must provide <a href='https://swagger.io/docs/specification/describing-parameters/#header-parameters' target="_blank">Header Parameters</a>

For GET requests, ensure you also provide the required <a href='https://swagger.io/docs/specification/describing-parameters/#query-parameters' target="_blank">query parameters</a>

For POST/PUT/DELETE requests, structure your request's <a href='https://swagger.io/docs/specification/2-0/describing-request-body' target="_blank">body parameters</a> in JSON format (application/json)

<aside class="warning">
Quick tip: You can <a href="./ezus_api_postman.json?attachmentlinks=true"  target="_blank" download>download here</a> a Postman export of this API
</aside>


















