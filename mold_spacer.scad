
// length of the spacer
l = 4;

// thickness of the spacer
t = 0.8;

// horizontal supports offset
ho = 2;

// vertical supports offset
vo = 3.5;

// diagonal bevels angle
a = 45;   

// // hairpin crossection ( 4 1/8 )
// hw = 25.6;  // width
// hh = 17.6;  // height
// hd = 25.6;  // distance between the diagonal bevels

// hairpin crossection ( 4 3/8 )
hw = 26.3;  // width
hh = 19.3;  // height
hd = 26.3;  // distance between the diagonal bevels

// mold inner dimensions
mw = 32.3;  // width
mh = 28.3;  // height


module grip_body( w, h, d, l )
{
   intersection( )
   {
      cube( [ w, h, l ], true );
      rotate( [ 0, 0, a ] )
      {
         cube( [ d,   d*2, l ], true );
      }
      rotate( [ 0, 0, -a ] )
      {
         cube( [ d,   d*2, l ], true );
      }
   }
}

difference( )
{
   union( )
   {
      grip_body( hw + 2*t, hh + 2*t, hd + 2*t, l );

      translate( [ 0, -ho, 0 ] ) { cube( [ mw, t , l ], true ); }
      translate( [ 0, ho, 0 ] ) { cube( [ mw, t , l ], true ); }
      translate( [ -vo, 0, 0 ] ) { cube( [ t , mh, l ], true ); }
      translate( [ vo, 0, 0 ] ) { cube( [ t , mh, l ], true ); }
   }

   grip_body( hw, hh, hd, l );
}
   

