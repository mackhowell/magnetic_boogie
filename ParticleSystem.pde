class ParticleSystem {

  ArrayList<Particle> particles;    // An arraylist for all the particles
  PVector origin;                  // An origin point for where particles are birthed
  //int[] fcolor = new int[100];    // **** TOOK THIS OUT FOR serialColors
  ArrayList<Integer> serialColors;      // **** SERIALCOLORS arrayList
  int maxspeed;
  //int particleNum;
  int initialColor;
  int listSize;
  int lastListSize;
  int particleCreator;

  ParticleSystem(PVector v, ArrayList<Integer> psConstructColor) {          //***********was: (int num, PVector v, ArrayList<Integer> psConstructColor)
    this.particles = new ArrayList<Particle>();                            // Initialize the arraylist
    this.origin = v.get();     // Store the origin point
    this.serialColors = psConstructColor;
    this.initialColor = this.serialColors.get(0);
    //this.particleNum = num;
    //    for (Integer ps : psConstructColor) {
    maxspeed = int(random(0, 100));
    
    listSize = 0;
    lastListSize = 1;
    particleCreator = 0;
    

    psCardSwipe(origin, initialColor, maxspeed);                 //**** was this.fcolor
    // Add "num" amount of particles to the arraylist
    //    }
  }

  void psCardSwipe(PVector cardswipe, int functionColor, int maxspeedtemp) {
    particles.add(new Particle(cardswipe.x, cardswipe.y, functionColor, maxspeedtemp));
  }

  void run(ArrayList<Integer> newColors, int listSize) {
    // Using the Iterator b/c we are deleting from list while iterating
    //Iterator<Particle> it = particles.iterator();
    //while (it.hasNext ()) {
    if (listSize > 0 ) {
      this.listSize = listSize;
      this.serialColors = newColors;
      if (listSize > lastListSize) {
        particleCreator = listSize - lastListSize;
        for (int i = lastListSize; i < listSize; i++) {
          maxspeed = int(random(0, 100));
          int newColor = serialColors.get(i);
          
          psCardSwipe(origin, newColor, maxspeed);
        }
      }
    }
    for (Particle v : particles) {
      //Particle v = it.next();
      v.cohesion(particles);
      // Call the generic run method (update, borders, display, etc.)
      v.update();
      v.borders();
      v.display();
    }
    lastListSize = listSize;
  }

  // write an add Particle function that makes a particle at a location

  void addParticle() {
    for (Integer ps : this.serialColors) {
      maxspeed = int(random(0, 100));
      psCardSwipe(origin, ps, maxspeed);            //**** was this.fcolor
      // Add "num" amount of particles to the arraylist
    }
  }

  //  // A method to test if the particle system still has particles
  //  boolean dead() {
  //    if (particles.isEmpty()) {
  //      return true;
  //    } 
  //    else {
  //      return false;
  //    }
  //  }
}

