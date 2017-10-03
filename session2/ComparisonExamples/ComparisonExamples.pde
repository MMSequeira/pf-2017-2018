int numberOfLives = 13;
float health = 10.0;

println(numberOfLives == 10);
println(numberOfLives != 10);
println(numberOfLives > 13);
println(numberOfLives >= 13);
health -= 6.0;
if (health < 5.0) {
  println("You're dead!");
}