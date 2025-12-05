# Feature Request: Cart Item Modification

I have a Flutter sandwich shop app with an order screen and a cart screen. I need to add functionality to let users modify items in their cart.

## Current Implementation
- **Models**: 
  - `Sandwich` (contains type, size/isFootlong, bread type)
  - `Cart` (has add/remove/clear methods and calculates total price)
- **Repository**: 
  - `PricingRepository` (calculates prices based on quantity and size only)
- **Current Cart Screen**: Displays list of sandwiches with their details, quantities, individual prices, and total price

## Required Features

### 1. Change Item Quantity
**Description**: Allow users to increment or decrement the quantity of each sandwich in the cart.

**UI Requirements**:
- Add "-" and "+" buttons next to each item's quantity display
- The "-" button should decrement quantity by 1
- The "+" button should increment quantity by 1

**Behavior**:
- When user taps "+": increase quantity by 1, update the item price and total price
- When user taps "-": decrease quantity by 1, update the item price and total price
- When quantity reaches 0 via decrement: remove the item from the cart entirely
- Disable the "-" button when quantity is 1 (to prevent going below 1)
- Update all prices in real-time as quantities change

### 2. Remove Item Completely
**Description**: Allow users to remove an item from the cart regardless of quantity.

**UI Requirements**:
- Add a "Remove" button or delete icon for each cart item
- Consider using a red color to indicate deletion

**Behavior**:
- When user taps remove: immediately remove the entire item from cart
- Update the total price
- If cart becomes empty: show an appropriate message like "Your cart is empty"

### 3. Clear Entire Cart
**Description**: Allow users to remove all items from the cart at once.

**UI Requirements**:
- Add a "Clear Cart" button at the bottom of the cart screen
- Use a prominent color (like red) to indicate this is a destructive action

**Behavior**:
- When user taps "Clear Cart": show a confirmation dialog asking "Are you sure you want to clear your cart?"
- If user confirms: remove all items and show "Your cart is empty" message
- If user cancels: close dialog and keep cart as is

## Technical Notes
- The cart screen should rebuild automatically when cart contents change
- All price calculations should use the existing `PricingRepository`
- Maintain the existing cart total price calculation
- Ensure the UI updates immediately when any modification occurs

## Expected File Changes
- Update `cart_screen.dart` to add the new UI controls and handlers
- Potentially update the `Cart` model if new methods are needed (e.g., updateQuantity)