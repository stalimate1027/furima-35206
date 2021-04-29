window.addEventListener('load', function(){

  const price = document.getElementById("item-price")
  price.addEventListener("input",() => {
    const inputValue = price.value;

  const fee = document.getElementById("add-tax-price")
  fee.innerHTML = Math.floor(inputValue / 10)
  
  const profit = document.getElementById("profit")
  profit.innerHTML = Math.floor(inputValue - fee.innerHTML)
  })
})