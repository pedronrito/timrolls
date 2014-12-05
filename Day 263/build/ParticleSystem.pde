import java.util.Iterator;

class ParticleSystem {
	int finger_which;
        int arrayPos;
	PVector pt;

	ArrayList<Particle> particles;
	int numParticles = 2;

	ParticleSystem(int _finger_which, PVector _pt, int _arrayPos) {
		finger_which = _finger_which;
                arrayPos = _arrayPos;
		pt = _pt;

		particles = new ArrayList<Particle>();

		for (int i = 0; i < numParticles; ++i) {
			Particle p = new Particle(i, finger_which, pt, arrayPos);
			particles.add(p);
		}
	}

	void run() {
		Iterator<Particle> it = particles.iterator();

		while( it.hasNext() ) {
			Particle p = it.next();
			p.run();

			if( p.isDead() ) it.remove();
		}
	}

	boolean systemDead() {
		return ( particles.isEmpty() );
	}
}