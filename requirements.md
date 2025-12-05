# Requirements Document: Cart Item Modification Feature

## 1. Feature Overview

### Purpose
Enable users to modify the contents of their shopping cart by adjusting item quantities, removing individual items, or clearing the entire cart. This gives users full control over their order before proceeding to checkout.

### Background
The sandwich shop app currently allows users to add sandwiches to their cart from the order screen and view the cart contents. However, once items are in the cart, users cannot make changes without returning to the order screen. This feature will provide in-cart editing capabilities.

### Scope
- Modify quantities of existing cart items
- Remove individual items from the cart
- Clear all items from the cart at once
- Real-time price updates reflecting cart changes
- User feedback for empty cart states

---

## 2. User Stories

### US-1: Adjust Item Quantity
**As a** customer  
**I want to** increase or decrease the quantity of items in my cart  
**So that** I can order the exact number of sandwiches I need without going back to the order screen

**Acceptance Criteria:**
- User can see "+" and "-" buttons next to each item's quantity
- Clicking "+" increases quantity by 1
- Clicking "-" decreases quantity by 1
- Item price updates immediately when quantity changes
- Total cart price updates immediately when quantity changes
- "-" button is disabled when quantity is 1

### US-2: Remove Single Item
**As a** customer  
**I want to** remove an item completely from my cart  
**So that** I can quickly delete items I no longer want without reducing quantity to zero

**Acceptance Criteria:**
- User can see a "Remove" button or delete icon for each cart item
- Clicking remove instantly deletes the item from cart
- Total cart price updates immediately
- UI clearly indicates this is a delete action (e.g., red color, trash icon)

### US-3: Clear Entire Cart
**As a** customer  
**I want to** clear all items from my cart at once  
**So that** I can start over with a fresh order without removing items one by one

**Acceptance Criteria:**
- User can see a "Clear Cart" button at the bottom of the cart screen
- Clicking "Clear Cart" shows a confirmation dialog
- Dialog asks "Are you sure you want to clear your cart?"
- Confirming removes all items from cart
- Canceling closes the dialog without changes
- Button uses a warning color to indicate destructive action

### US-4: View Empty Cart State
**As a** customer  
**I want to** see a clear message when my cart is empty  
**So that** I understand that I need to add items from the order screen

**Acceptance Criteria:**
- When cart has no items, display "Your cart is empty" message
- Empty state appears after clearing cart or removing last item
- Message is centered and clearly visible

---

## 3. Subtask Breakdown

### Subtask 3.1: Implement Quantity Adjustment UI and Logic

**Description:** Add increment/decrement buttons for each cart item and handle quantity changes.

**Technical Requirements:**
- Add Row widget with "-" and "+" IconButtons for each cart item
- Implement `_incrementQuantity(Sandwich sandwich)` method
- Implement `_decrementQuantity(Sandwich sandwich)` method
- Call `setState()` to rebuild UI after quantity changes
- Use existing `PricingRepository.calculatePrice()` for price updates
- Disable "-" button when `quantity == 1`

**Acceptance Criteria:**
- ✓ "+" button increases quantity by 1
- ✓ "-" button decreases quantity by 1
- ✓ "-" button is visually disabled (grayed out) when quantity is 1
- ✓ Item price updates immediately
- ✓ Total price updates immediately
- ✓ When quantity decremented to 0, item is removed from cart

**Files to Modify:**
- `lib/views/cart_screen.dart`

---

### Subtask 3.2: Implement Individual Item Removal

**Description:** Add a remove button for each cart item that deletes the item completely.

**Technical Requirements:**
- Add IconButton with delete/close icon for each cart item
- Implement `_removeItem(Sandwich sandwich)` method
- Call `widget.cart.remove(sandwich)` to delete item
- Call `setState()` to rebuild UI
- Use red or warning color for the icon

**Acceptance Criteria:**
- ✓ Remove button is visible for each cart item
- ✓ Clicking remove deletes the item immediately
- ✓ Total price updates after removal
- ✓ UI updates to show remaining items
- ✓ Button is clearly styled as a delete action

**Files to Modify:**
- `lib/views/cart_screen.dart`

---

### Subtask 3.3: Implement Clear Cart Functionality

**Description:** Add a button to clear all cart items with confirmation dialog.

**Technical Requirements:**
- Add "Clear Cart" button at bottom of screen (after total price)
- Implement `_clearCart()` method that shows confirmation dialog
- Use `showDialog()` with AlertDialog widget
- Dialog should have "Cancel" and "Confirm" buttons
- On confirm: call `widget.cart.clear()` and `setState()`
- On cancel: close dialog with `Navigator.pop()`
- Style button with red/warning color

**Acceptance Criteria:**
- ✓ "Clear Cart" button is visible at bottom of cart screen
- ✓ Clicking button shows confirmation dialog
- ✓ Dialog displays "Are you sure you want to clear your cart?" message
- ✓ "Cancel" button closes dialog without changes
- ✓ "Confirm" button removes all items from cart
- ✓ UI updates to show empty cart state after clearing

**Files to Modify:**
- `lib/views/cart_screen.dart`

---

### Subtask 3.4: Implement Empty Cart State

**Description:** Display appropriate message and UI when cart is empty.

**Technical Requirements:**
- Check if `widget.cart.items.isEmpty` in build method
- Show centered Text widget with "Your cart is empty" when empty
- Hide cart items list and total price when empty
- Keep "Back to Order" button visible
- Use appropriate text style (e.g., `heading2` or `normalText`)

**Acceptance Criteria:**
- ✓ "Your cart is empty" message displays when cart has no items
- ✓ Message appears after clearing cart
- ✓ Message appears after removing last item
- ✓ No cart items or total price shown in empty state
- ✓ "Back to Order" button remains accessible

**Files to Modify:**
- `lib/views/cart_screen.dart`

---

### Subtask 3.5: Update Cart Model (if needed)

**Description:** Add helper methods to Cart model if direct manipulation is needed.

**Technical Requirements:**
- Review existing `Cart` class methods (`add`, `remove`, `clear`)
- Add `updateQuantity(Sandwich sandwich, int newQuantity)` method if needed
- Ensure all methods properly recalculate `totalPrice`
- Maintain immutability principles where applicable

**Acceptance Criteria:**
- ✓ Cart model has all methods needed for cart modifications
- ✓ Methods properly update internal state
- ✓ Total price recalculates correctly after any modification
- ✓ Methods handle edge cases (e.g., quantity of 0)

**Files to Modify:**
- `lib/models/cart.dart` (if needed)

---

## 4. Overall Acceptance Criteria

The feature is considered complete when:

1. ✓ Users can increment/decrement quantities for any cart item
2. ✓ Users cannot decrement below quantity of 1 (button is disabled)
3. ✓ Items are automatically removed when quantity reaches 0 via decrement
4. ✓ Users can remove items completely using a dedicated remove button
5. ✓ Users can clear the entire cart with a confirmation dialog
6. ✓ All price calculations update in real-time
7. ✓ Empty cart state displays appropriate message
8. ✓ All UI elements follow existing app styling (`app_styles.dart`)
9. ✓ No errors or crashes occur during any cart modification
10. ✓ Cart state persists correctly across screen navigation

---

## 5. Technical Constraints

- Must use existing `Cart` model methods where possible
- Must use existing `PricingRepository` for all price calculations
- Must maintain existing `StatefulWidget` pattern in `cart_screen.dart`
- Must follow existing app styling conventions from `app_styles.dart`
- Must handle state updates properly using `setState()`

---

## 6. Out of Scope

The following are explicitly NOT included in this feature:

- Editing sandwich details (type, size, bread) after adding to cart
- Undo/redo functionality
- Cart persistence across app restarts
- Animations for item removal or quantity changes
- Maximum quantity limits per item (beyond the order screen's `maxQuantity: 5`)
