// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import * as bootstrap from "bootstrap"

// Initialize Bootstrap components
document.addEventListener("turbo:load", function() {
  // Initialize all tooltips
  var tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'))
  var tooltipList = tooltipTriggerList.map(function (tooltipTriggerEl) {
    return new bootstrap.Tooltip(tooltipTriggerEl)
  })

  // Initialize all popovers
  var popoverTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="popover"]'))
  var popoverList = popoverTriggerList.map(function (popoverTriggerEl) {
    return new bootstrap.Popover(popoverTriggerEl)
  })

  // Smooth scroll for anchor links
  document.querySelectorAll('a[href^="#"]').forEach(anchor => {
    anchor.addEventListener('click', function (e) {
      e.preventDefault()
      document.querySelector(this.getAttribute('href')).scrollIntoView({
        behavior: 'smooth'
      })
    })
  })

  // Add animation classes when elements come into view
  const observer = new IntersectionObserver((entries) => {
    entries.forEach(entry => {
      if (entry.isIntersecting) {
        entry.target.classList.add('fade-in')
      }
    })
  })

  document.querySelectorAll('.fade-in').forEach((el) => observer.observe(el))
})

// Handle search bar interactions
document.addEventListener("turbo:load", function() {
  const searchInput = document.querySelector('.search-bar input')
  if (searchInput) {
    searchInput.addEventListener('focus', function() {
      this.parentElement.parentElement.classList.add('shadow-lg')
    })

    searchInput.addEventListener('blur', function() {
      this.parentElement.parentElement.classList.remove('shadow-lg')
    })
  }
})

// Handle filter interactions
document.addEventListener("turbo:load", function() {
  const filterSelects = document.querySelectorAll('.filters select')
  filterSelects.forEach(select => {
    select.addEventListener('change', function() {
      // Add your filter logic here
      console.log('Filter changed:', this.value)
    })
  })
})
