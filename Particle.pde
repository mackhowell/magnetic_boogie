class Particle {

  // All the usual stuff
  PVector location;
  PVector velocity;
  PVector acceleration;
  float r;
  float maxforce;    // Maximum steering force
  float maxspeed;    // Maximum speed
  int fcolor;

    // Constructor initialize all values
  Particle(float x, float y, int particleColor, int maxspeed) {
    location = new PVector(x, y);
    r = 25;
    this.maxspeed = maxspeed;
    maxforce = 0.2;
    acceleration = new PVector(0, 0);
    velocity = PVector.random2D();
    this.fcolor = particleColor;
    
  }

  void applyForce(PVector force) {
    // We could add mass here if we want A = F / M
    acceleration.add(force);
  }

  // Separation
  // Method checks for nearby particles and steers away
  void cohesion (ArrayList<Particle> particles) {
    float desiredseparation = r*5;    // how far each particle the drifts
    PVector sum = new PVector();
    int count = 0;
    // For every boid in the system, check if it's too close
    for (Particle other : particles) {
      float d = PVector.dist(location, other.location);
      // If the distance is greater than 0 and less than an arbitrary amount (0 when you are yourself)
      if (d > desiredseparation) {
        // Calculate vector pointing away from neighbor
        PVector diff = PVector.sub(location, other.location);
        diff.normalize();
        diff.mult(-d);      // Weight by distance
        sum.add(diff);
        count++;            // Keep track of how many
      }
    }
    // Average -- divide by how many
    if (count > 0) {
      sum.div(count);
      // Our desired vector is the average scaled to maximum speed
      sum.normalize();
      sum.mult(maxspeed);
      // Implement Reynolds: Steering = Desired - Velocity
      PVector steer = PVector.sub(sum, velocity);
      steer.limit(maxforce);
      applyForce(steer);
    }
  }



  // Method to update location
  void update() {
    // Update velocity
    velocity.add(acceleration);
    // Limit speed
    velocity.limit(maxspeed);
    location.add(velocity);
    // Reset accelertion to 0 each cycle
    acceleration.mult(0);
  }

  void display() {
    colorMode(HSB,255);
    fill(fcolor, 255, 255, 50);
    noStroke();
    pushMatrix();
    translate(location.x, location.y);
    rect(0, 0, r, r);
    popMatrix();
  }

  // Wraparound
  void borders() {
    if (location.x < -r) location.x = width+r;
    if (location.y < -r) location.y = height+r;
    if (location.x > width+r) location.x = -r;
    if (location.y > height+r) location.y = -r;
  }
}






