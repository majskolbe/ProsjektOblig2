#function for putting together flags with undefined variables
fun make-flag(width, height, measure1, measure2, color1, color2, color3, place1, place2):
  rectangle1 = rectangle(width, height, "solid", color1)
  rectangle2 = rectangle(width, measure1, "solid", color2)
  rectangle3 = rectangle(measure1, height, "solid", color2)
  rectangle4 = rectangle(width, measure2, "solid", color3)
  rectangle5 = rectangle(measure2, height, "solid", color3)
  
  put-image(rectangle3, place1, place1, 
    put-image(rectangle2, place2, place1,
      put-image(rectangle5, place1, place1, 
        put-image(rectangle4, place2, place1,
         rectangle1))))
end


#Defining the different variables for each flag
norway = make-flag(220, 160, 20, 40,  "red", "darkblue", "white", 80, 110)

sweden = make-flag(160, 100, 20, 20, "blue", "yellow", "blue", 50, 80)
  
denmark = make-flag(370, 280, 40, 40, "red", "white", "red", 140, 185)

finland = make-flag(180, 110, 30, 30, "white", "darkblue", "white", 55, 90)

iceland = make-flag(250, 180, 20, 40, "blue", "red", "white", 90, 125)

faroeIslands = make-flag(220, 160, 20, 40, "white", "red", "darkblue", 80, 110)


#printing out the flags
norway
sweden
denmark
finland
iceland
faroeIslands

