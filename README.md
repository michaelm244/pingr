
# pingr
---
To use Pingr:

1. Create a div with an id of "pingr" and put it where you want the Pingr box to appear:
  ```html
  <div>id="pingr"</div>
  ```

2. Insert this script at the end of the body:
  ```html
  <script src="www.mattheakis.com/pingr/pingr.js"></script>
  ```
  
3. Call this function with desired width/height of the Pingr box
  ```javascript
  Pingr.init(width, height)
  ```