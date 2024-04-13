// Racquet with strings no grip no buttcap 288g

// Segments in a circle, increase for the final render
$fn = 40;

// crossection
w = 32.3;  // width
h = 28.3;  // height
d = 31.8;  // distance between the diagonal bevels
a = 45;    // diagonal bevels angle

// full grip length
gl = 200;

// throat
tl = 30;  // length of the transition between grip and throat
th = 22;  // height of the throat
tw = 31.5; // width of the throat
r1 = 5.5; // x-rounding (where the short side connects to the long)
r2 = 11;  // y-rounding (at the middle of the short 'rounded' side)

// 'collar' above the throat
cl = 2;

// pins/holes
ro = 2;
ri = 1.7;
ox = 1;
oz = 2;

// full length of the mold, grip length + collar
ml = gl + cl;

// mold outer dimensions
mw = w + 12;
mh = h + 6;

module throat_rounding( l )
{
   scale( [ 1, r2/r1, 1 ] ) { cylinder( l, r = r1 ); }
}

module throat( l )
{
   hull( )
   {
      translate( [ (tw/2 - r1),   th/2 - r2 , 0 ] )  { throat_rounding( l ); }
      translate( [ (tw/2 - r1), -(th/2 - r2), 0 ] )  { throat_rounding( l ); }
      translate( [ -(tw/2 - r1),   th/2 - r2 , 0 ] ) { throat_rounding( l ); }
      translate( [ -(tw/2 - r1), -(th/2 - r2), 0 ] ) { throat_rounding( l ); }
   }
}

module grip_body( l )
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

module grip_shape( )
{
   translate( [ 0, 0, gl ] )
   {
      throat( cl );
   }

   hull( )
   {
      translate( [ 0, 0, gl-1e-2 ] )
      {
         throat( 1e-2 );
      }

      translate( [ 0, 0, gl-tl+1e-2/2 ] )
      {
         grip_body( 1e-2 );
      }
   }
   translate( [ 0, 0, (gl-tl)/2 ] )
   {
      grip_body( gl-tl );
   }
}

module full_mold( )
{
   difference( )
   {
      translate( [ 0, 0, ml / 2 ] )
      {
         cube( [ mw, mh, ml ], center = true );
      }

      grip_shape( );
   }
}

module half_mold( )
{
   difference( )
   {
      full_mold( );

      translate( [ 0, mh / 2, ml / 2 ] )
      {
         cube( [ mw, mh, ml ], center = true );
      }
   }
}



difference( )
{
   union( )
   {
      half_mold( );

      translate( [ mw/2-ro-ox, 0,    ro+oz ] ) { sphere( ri ); }
      translate( [ mw/2-ro-ox, 0, ml/2     ] ) { sphere( ri ); }
      translate( [ mw/2-ro-ox, 0, ml-ro-oz ] ) { sphere( ri ); }
   }

   union( )
   {
      translate( [ -(mw/2-ro-ox), 0,    ro+oz ] ) { sphere( ro ); }
      translate( [ -(mw/2-ro-ox), 0, ml/2     ] ) { sphere( ro ); }
      translate( [ -(mw/2-ro-ox), 0, ml-ro-oz ] ) { sphere( ro ); }
   }
}
