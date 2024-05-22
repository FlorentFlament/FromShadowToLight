frame_cnt       ds.w    1

;;; clip variables
clip_counter    ds.b    1
clip_index      ds.b    1

;;; ptr = tt_ptr		; Reusing tt_ptr as temporary pointer
banksw_ptr      ds.w    1
ptr             ds.w    1               ; temporary pointer
ptr1            ds.w    1

;;; picture playfields pointers
pic_p0  ds.w    1
pic_p1  ds.w    1
pic_p2  ds.w    1
pic_p3  ds.w    1
pic_p4  ds.w    1
pic_p5  ds.w    1
