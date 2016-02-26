---
date: 2016-02-04T17:16:36-07:00
title: 0x02 - JP Aumasson on Password Hashing and Argon2
image: /static/images/casts/key.jpg
cast: http://traffic.libsyn.com/thestormcast/stormcast-episode-0x02-jp-aumasson-on-password-hashing-and-argon2.mp3
summary: >
  In this episode, we'll talk with JP Aumasson, a highly respected cryptographer
  who's dedicated most of his professional life to making your passwords more
  secure. He ran the Password Hashing Competition, which just selected a new
  *most secure* password hashing algorithm: Argon2.
---


**Randall**: Alright. Hi everyone, how is it going? Welcome back to episode two
of Stormcast, the most awesome web security podcast. In this episode we're going
to talk about the latest and greatest password hashing algorithm, Argon2,
you've probably heard about it around the internet lately. We're going to
discuss what it is, what it's used for a bit of a history about and how it
works, we're also going to discuss why it beat out the other popular hashing
algorithms in the password hashing competition that just wrapped up recently,
and why it's now the recommended password hashing algorithm for everyone to use
going forward.  We have a really awesome guest today: JP Aumasson, the principal
cryptographer at Kudelski Security, so before we get into it, as always I'm
Randall Degges the host, and thanks a bunch to our sponsor for the show
[Stormpath](https://stormpath.com/), so let's get into it. Hey JP how's it going
thanks for joining the show.

**JP**: Hi Randall thanks for having me, it's going to be my first podcast so
I'm happy to be here.

**Randall**: Awesome yeah man. Just so you guys know, JP's a really famous
cryptographer and security guy. He's done a bunch of stuff, I mentioned before:
he's the principal cryptographer at Kudelski Security a Swiss security firm
which provides security services in a ton of different industries. He also ran
the password hashing competition, from 2013 to 2015 which aimed to find the best
password hashing algorithm for modern developers to use, he's also the author of
a popular hashing algorithm, Blake which is one of the finalists in the NIST
competition which ran from 2007 to 2012.  He's the author of an authenticated
cipher named NORX which is a candidate in the CAESAR competition which has been
running since 2012 and that's expected to wrap up in 2017, so good luck with
that. He also runs, I know I'm going on forever here but this guy's pretty
amazing, he also runs a cryptography coding standard site which provides a set
of coding rules that helps prevent most common weaknesses in cryptographic
software implementations and pretty much a million other really cool things.  So
again, thanks for being on the show man this is going to be awesome, really
appreciate it. To get started, tell me a little bit about how you got into
cryptography.

**JP**: Well thanks for the nice introduction Randall. How did I get started? It
was about maybe 10 years ago. I was doing my masters in some University in
*<indiscernible>* at some point you need to specialize in some field, so
there are two fields that really fascinated me, they were Artificial
Intelligence and Cryptography. I was reading a lot of books about this and I
wasn't sure. I was leaning towards crypto. You know students they were like
"There's a lot of math, it's too complicated".  I was a bit scared I was not a
really mathematical guy, but the best thing is that I had a girlfriend in
Lausanne in Switzerland I was leaving *<indiscernible>* there was this great
love of crypto at EPFL the big engineering school in Lausanne Switzerland,
so that was the best thing I decided to do crypto. I forgot my AI books and
focused on this by doing internship at this place and then I did PHD in
Switzerland and another school in Galen. And then I decided to stick around
because it's a much better place to live and work than where I was before, so
it has a story.

**Randall**: What happened with the girl?

**JP**: I married her and I got a kid...

**Randall**: Wow congratulations man, that's a nice happy ending to a story.
What sort of motivated you to get into all the applied security research you do,
and what sort of keeps you motivated to do all the stuff you do. Like running
the password hashing competition, creating your own password hashes, being
really involved in... Sort of evangelizing this stuff in the community, I've seen
some of the talks you gave at DEFCON they are all really great. What motivates
you to go out there and do all this stuff.

**JP**: I think maybe the core reason is, it just comes out of some frustration
I had because I was doing a PHD from about 2006 to 2009 and I was seeing a lot
of very smart people doing very sophisticated research and ciphers and regular
ciphers, but everything disconnected from addiction, from reality and this time
we have echo chamber where we have academics publishing papers and academics
writing papers and I have seen the quality of papers and from my point of view
this all wasted talented, wasted energy here.  I said "okay so let's try to
bring this whole academic background and make it useful for real application,
for people, for the community", and well it was fun to break ciphers that
nobody's using but I wanted to break ciphers that people were using, it's much
funnier. I learned a lot on the tier of crypto, mathematical notions, all this
stuff but I didn't really try to go to industry because I was more interested in
real world applications, in making an impact.  That's why I went to those
academic conferences, where you have like 20 people in the room, talking of
DEFCON like have I don't know a thousand people and a much different game...

**Randall**: Here's another question, actually I know you did all that PHD stuff
in complex academic background, what is the difference like in the academic
 crypto world? I mean is it really serious and sort of like... I guess like the way
it's portrayed at least in sort of the industry out here it's sort of boring and
people are constantly trying to publish papers about whatever, did you like the
academic side of things or was it...

**JP**: It's just much more focused. People who work in a very specific field or
very specific sub-field *<indiscernible>* for four years. I think it's more about
diminishing returns, make a lot of effort to get this one person *<indiscernible>*
of security and they make a lot of effort to make things right mathematically
speaking to get proofs of security, to work within a surgical model, but the
problem is they overlook the real world constraints.  You implement your cipher
in some computer, with some services running, some operating system some net
operations and the risk of cryptography is very, very small. Most of the time
cryptography will be your strongest link in your security system. That's from
only what academic guys sometimes fail to see. They focus on problems that are
not problems that people care about, that people never care about and people in
industry don't have time to focus on cryptography on the real problems they
face.  I am trying to evangelize to doctorate, to the academic force, to tell
them that "you know there's this problem that the industry are trying to solve,
they don't have all the tools, maybe you can help them and there's been a whole
lot of people or conferences trying to bridge the gap between the two communities
and I think it's getting better over the years compared to five years ago.

**Randall**: That makes perfect sense, so and a follow up question to that too,
I know you've done this huge like wide array of different things in the crypto
community, but I noticed a lot of what you've done has been focused around
password hashing in particular, or not just password hashing, hashing algorithms
in particular. What sparked your interest in that over stuff like file
encryption or just like AES type stuff, where you're actually encrypting data as
opposed to this one way like hashing algorithms and things.

**JP**: It was a question of time because there was the AES that was selected in
2003. The problem of a block cipher isn't really solved and later between 2005
and 2008 there was another competition called e-stream for stream ciphers so
when I started my PHD I was *<indiscernible>* in these two but the big thing is
that NIST was starting the SHA 3 competition in 2008 and I was doing my PHD.  I
knew nothing about hash function so I didn't know what was hash function before,
and my supervisors told me "you should get in this game and submit something to
the SHA 3 competition", I was like "the other guys have been working on this for
10 years, they were much better than me" but I started learning hash functions
then I got very interested in this I submitted Blake to the SHA 3 competition
and when we submitted this, there were other contestants in the competition.  I
learned a lot to try to break the other hash functions, so I learned a lot about
this and that's why I became quite an expert in this field and then I designed
SipHash which is another hash function for different types of application.

**Randall**: Was Blake the first hashing algorithm you created?

**JP**: Yeah, the first good one let's say. I created another one and it just
got published at some conference, it was a bit similar to Blake but not really
good.

**Randall**: If I remember correctly, correct me if wrong, but wasn't Blake one
of the finalist in that completion as well?

**JP**: Yeah it was about one of the five finalists... NIST choose it for good
reasons I think, I was sitting in NIST offices just two weeks ago, and we
chatted about it and they said...I told them "Guys, I think you were right in
picking Keccack" because of their own criteria.

**Randall**: Was it a lot of fun to create a hashing algorithm that sort of gets
that much respect in the community? I mean, I imagine it must feel pretty
awesome to build something that is runner up for basically a complete
standardization process. It must feel pretty good.

**JP**: It is quite rewarding when you're a junior researcher and you say "Oh,
this very experienced guy did... They think its good work" all this smart guys,
they try to break it, they spent I don't know hundreds of hours trying to break
it and they didn't succeed, so maybe I did something right.

**Randall**: Awesome, well okay, so let's get into the first sort of section
here. Now a lot of our listeners have tons of different backgrounds, so there's
a lot of like beginning programmers, more intermediate and also a lot of more
advanced guys as well. In this first section here I wanted to ask you some
questions about, password hashing in particular, so let's just cover sort of the
basics and make sure we can figure out... Explain to everyone what all the purposes
of this stuff is and what it can be used for and what not. First question, what
is the meaning of hashing in the context of cryptography and how does it differ
from non-cryptography related hashing, like what's the difference between those
two?

**JP**: I'll answer the first question to clarify because there's at least two
types of hash functions the cryptographic ones and the non-cryptographic ones
and the non-cryptographic hash, you just want it to look random to be
statistically random, thus far, you're going to use any hash tables and you
don't care really care about security, you don't have any attacker playing with
this hash function.

**Randall**: Does that mean basically for a non-crypto hash function you
essentially don't care if it can be reversed? Is what you're saying.

**JP**: Right, exactly. You don't have any *<indiscernible>* issues, the
attacker trying to trying to modify the hash or to reverse it...

**Randall**: Then I guess the purpose of cryptographic hash function is to make
it as hard to reverse as possible or impossible, right?

**JP**: Yep, and marginally you want it to behave like a random function, to
have no property whatsoever that makes it easy to reverse or easy to find
collisions, so this is my part about collision resistance where the game is to
find two different *<indiscernible>* two different values at hash to decipher
is of hash. A hash value is usually between 128 and 512 bits and the input can
be of any size, it can be one bit it can be one gigabyte it can be any size
and you also want it to be pre-image resistant. Pre-image resistance means
that you are given a hash value and you're not given the message and the game
is to find a message that gives this hash value *<indiscernible>*.

**Randall**: I guess the only way to do that if you're working with a
cryptographic hash function is just to brute force it essentially right? You
basically try like "I'm going to hash the letter A and see if that equals the
hash I'm trying to break", and then "I'm going to hash the letter B", and so
forth and so on right?

**JP**: Yeah, and if you have like 120 bits of hash it will take you like two to
three, 128 test two to find a pre-image. It's little different for collisions
*<indiscernible>* where you only just try the square root of the space, meaning
that you need 2364 values to find a collision for 120 bit hash it's much, much
easier in terms of surgical complexity if you would.

**Randall**: That makes sense. Okay let's talk about some high level stuff, so
what it is sort of the general purpose for a cryptographic hash function? What
do people use this for when they're building web apps or code in their day to
day jobs?

**JP**: We usually call them the Swiss army knife of crypto because you can use
it in so many applications, it's going on to be used in digital signatures, like
when you have your SSL certificate, you have the *<indiscernible>* and you have
the hash function that's used. We use it for message authentication, so like in
SSH, IPsec or TLS when you encrypt the traffic but you don't only encrypt the
packets, you also authenticate them.  You go get a small hash, you combine the
hash with a key and this gives you a kind of signature of the datagram policy,
you also use a hash function and even to encrypt like in RSA to use RSA to encrypt
*<indiscernible>* body, and inside the encryption algorithm at some point you use
a hash function. It's kind of different everywhere.

**Randall**: I guess the other real popular use case is of course like storing
stuff like passwords, right?

**JP**: Yep, even though in that case its slightly different hash functions, at
least you're supposed to, but that maybe the application that developers
nowadays most of them say "oh we should hash passwords", sometime they say "we
should encrypt passwords", which is wrong...

**Randall**: Yeah, you never want to encrypt a password, right? You always want
to hash it, because you don't want it to be reversible.

**JP**: Yep, I think there's one reason why some developers get it wrong.
There's this confusion, the term hashing you know I say "oh I should hash the
password", so I will pick what "a hash function"...

**Randall**: Okay so that's... Cryptographic hashing obviously has a wide set of
uses, what is the use for non-cryptographic hashing functions? What is their
purpose in practical applications?

**JP**: Sometimes, people may have heard about the CRCs, it's also called
checksums, it's kind of very weak hash but very fast compute, it's what you
usually have at the end of *<indiscernible>* of internet frames to make an
operation. Uses kind of weak hash also when you have no attacker but you may
have some accidental errors, and you will check the hash to check it hasn't been
*<indiscernible>* transmission.

**Randall**: What you're essentially talking about is stuff like MD5 and SHA1
right?

**JP**: Yes, probably the two best known hash functions, MD5 I think it was
designed in the early 90s same for SHA1. The bottom line is that you should not
be using them today because they are broken. Cryptographers have been saying for
maybe 20 years don't use MD5.

**Randall**: People keep using it all the time. Okay so yeah, I was actually
about to lead into that, to talk about that. I feel like most developers even
beginners when they start getting into programming are going to hear about MD5
and SHA1 pretty much all the time, especially when they're doing stuff like
downloading files, or binary releases of software whatever, you pretty much all
the time see like "Verify the MD5 sum", stuff like that.  People know about a
little bit, so since you just said people should not really be using these, are
those functions still usable for purposes of like verifying a file's integrity?
Or would you say people should be using other stuff for that purpose as well.

**JP**: I would recommend to ditch MD5 and SHA1 altogether but the problem of
developers sometimes, you know you have an API, you have a library sometimes the
only thing you have is SHA1, or sometimes the default SHA is SHA1 or you have to
pass an extra parameter to use a non-default hash, it's not really easy to use
something to figure out what's going on *<indiscernible>*. You may be using SHA1
or MD5 without knowing it, but if you do have the choice for whatever application
you should go with SHA256 today.  Then you don't have to care whether or not the
properties of SHA1 or MD5 make it strong enough for your application. There might
be some cases where using SHA1 might still be okay but you don't want
*<indiscernible>* about it. SHA1 will probably be more broken in coming years...

**Randall**: Basically what're you're saying is in general if you have the
option you should always use at minimum SHA256 to do stuff like verify file
integrity and stuff like that?

**JP**: Yep and also I think what people *<indiscernible>* forward is that SHA2
have this property that makes it insecure in some specific cases. It's called the
length extension it's like *<indiscernible>* hash up some value and what you can
do is, you take the hash value and even if you don't know the message that was
used you can compute the hash of a longer message without knowing the prefix,
without knowing the initial message.  The *<indiscernible>* is that if you go
with SHA3 *<indiscernible>* bottom functions, there is none of these caveats none
of these strange properties *<indiscernible>* I would even recommend something
like commercial *<indiscernible>* Blake2.

**Randall**: Yeah feel free to plugin man, you're the expert, so people will
listen to what you recommend so go for it.

**JP**: I started in MD5 like before all, like when I was saying to my
colleagues five years ago "Guys switch to SHA1 from MD5" and they were telling
me "No but SHA1 is slower, so you know what but Blake2 looks brilliant", blah,
blah, blah and now today you don't have this excuse you have functions that are
faster than MD5 and way more secure.

**Randall**: Wait so you're saying Blake2 is faster than MD5?

**JP**: Yeah, on many CPUs. Depends on the architecture, micro-architecture how
you *<indiscernible>* but on your laptop it will be faster.

**Randall**: Wow that's crazy... So isn't... So correct me if I'm wrong here, but MD5
is built into TCP/IP correct? For like packet fragmentation and stuff?

**JP**: I guess so.

**Randall**: The MD5 algorithm is actually built-in to the TCP/IP protocol isn't
it to verify packets?

**JP**: I've seen in TLS it's one of the options that is getting obsolete and
replaced by stronger hashes.

**Randall**: Oh wow, that's really cool and again is Blake2 a contender for
replacing it by any chance?

**JP**: Not yet, we do have an RFC we're discussing with OpenSSL to be
interpreted in the OpenSSL stack, but it takes a lot of time to deployed into
public systems because you need the function to be tested, to be approved by
many people, the implementation to be verified, its lot of work, so its lot of
politics sometimes but things eventually move on.

**Randall**: Very cool so let's talk about this. You mentioned a few minutes ago
there's cryptographic hashes, which cannot be reversed but those are quite
different from password hashing algorithms right? They both have different sets
of requirements, so could you talk a little bit about that. What are the
fundamental differences that you should be aware of when you're looking to
evaluate like a password hashing algorithm versus a cryptographic hashing
algorithm? What should be people be aware of?

**JP**: Yeah, so the single biggest difference that a normal hash, a general
purpose hash you want it to be as fast as possible because you want to verify as
many signatures per second as possible, for password hashing it's different, you
want it to be as slow as possible and to have a thoroughbred performance on your
system. Why you want it to be slow is because when you hash password you hash a
secret that's usually sometimes easy to guess, you only have so many different
passwords and attackers can try all of the different possible passwords.  You
can take words from dictionaries, you can brute force, take all combinations of
printable characters and can be very fast, like if you take MD5 now people are
using, graphic cards, GPUs and all these stuff and assume they can test all the
possible passwords of eight characters in less than one hour using a cluster of
GPUs. Now if you make hashing slow, like a thousand times slower, it becomes a
thousand times slower to crack it so instead of one hour it will take you
thousand hours.  That's the idea of password hashing, of making it more
generally more costly for the attacker in terms of time, in terms of memory, in
terms of budget, of hardware/software whatever and the big difference between
this and normal hashing is that it's not mathematical challenge, it's an
engineering challenge, because you have to look at "what kind of CPU am I
using?", "what instructions are in my CPU?", "what *<indiscernible>* hardware
today?", "what will be tomorrow?" so that's much more complex problem.

**Randall**: That makes sense, so let's talk about this a little bit more, about
the password hashing stuff here, because I feel like in the context of web
developers, that comes up a lot obviously, like what is the best sort of way to
store your passwords, what sort of hashes should you be using and stuff like
that, so let's talk about this. I've seen, in my job actually I work with a lot
of different security protocols and stuff, like implementing stuff into websites
in particular and I get to look at a lot of user databases and I see all sorts
of weird patterns.  For instance I see a lot of people use SHA256 with like a
certain amount of iterations. Let's say they'll use a thousand iterations of
SHA256, so I guess what I want you to answer is could you sort of explain like,
if you take a fast hashing function like SHA256 and just add iterations to it is
that actually slowing you down enough to be effective at password hashing?  Or
is that not sufficient?

**JP**: Well the first thing is, like if you take SHA256 a thousand times and if
you hash my password and get a hash and if you hash your password and compute a
hash too, well if we have the same password, you will see the same two hash
values and when you have database of many users, all the users having the same
password, you will have the same hash and you can brute force passwords, like
for all users simultaneously.

**Randall**: You're talking about essentially like rainbow tables right?

**JP**: Yeah You can use rainbow tables for this and talking about what people
invented in the 70s having a salt, salt is small piece of data that you will
hash jointly with the password and the purpose of this is to simulate different
functions, so you're going to hash the same password twice but with a different
salt and you will get a completely different hash. This could make it much
harder to attack, to rainbow tables, timer trade-offs so all those things you
can fix by pre-computing a huge lot of data, huge tables of gigabytes, terabytes
and then using them for cracking the passwords much faster.  This could not work
if you have a salt. *<indiscernible>* the salt it like creates different
functions and the rainbow tables are for one specific function. Now let's
say you SHA256, *<indiscernible>* terations, you use a salt then I'm guessing
you're already pretty well off compared to people who do not hash the passwords
at all or who encrypt them or who use MD5 *<indiscernible>*.

**Randall**: Just store it in plain text, I guess it's a little better than
that.

**JP**: The limitation here is that if you just iterate fast hash functions so
it will be slower obviously but for the attacker it will be easy to use more
hardware, to use GPUs to paralyze it. You won't get an optimal defense against
attackers, whereas if you use a hash function that takes a lot of memory like a
couple of megabytes even more then this makes the job much harder for attackers
because on GPUs and hardware and FPGAs using a lot of memory it produces a lot
of latency and make it much slower.

**Randall**: Let's talk about that a little bit more, so like password hashing.
I guess the general gist of what you're saying is that, when you want to hash a
password securely, you want the algorithm to be as expensive as possible to
compute so like you want it to take a lot of CPU time, want it to take a lot of
memory, and that's the main goal right?

**JP**: You want to like leverage your hardware, the hardware of the defender,
like if you have a CPU with dedicated AES instructions that are extremely fast,
if you have low latency memory, cache memory of 10 megabytes then you want to
use this because your attacker, he may have hardware that could be less
efficient like a GPU. It used to be that shared memory was quite of a mess
and very slow on FPGA on *<indiscernible>* a system's too complicated so you
want to make something that is very nice for the defenders hardware and very
annoying for the attacker.

**Randall**: Got you, so with that in mind, I'm sure you're very familiar with
stuff like Bcrypt and Scrypt and those algorithms, so in the web development
world at least it seems like a lot of people over the last few years due to
different articles have come to the conclusion like if you're storing passwords
for a website use should probably be using either the Bcrypt algorithm or the
Scrypt algorithm. Could you talk a little bit about both of those algorithms
and what the benefits are for them and what's wrong with them and then a
little bit about why they might not be the best choice to use today?

**JP**: Yeah, I think these are the main recommendations today along with
PBKDF2 so Password Based Key Derivation Function number two which is a NIST
AFIB standard which is why many people use it. So Bcrypt was designed in 1999
the same year as PBKDF2 and then *<indiscernible>* was like make it slow but
not just slow but use a lot of memory, and then a lot of memory was four
kilobytes, so it was fine then but today it's much too old to mitigate GPU
attacks but in Bcrypt at least you have a time cost parameter, you can tweak how
long it takes number of iteration so something similar.  Bcrypt its used, I
wouldn't say it's used a lot, seeing that Twitter is using it, not so many
applications are using Bcrypt. I really don't know why, maybe more are using
PBKDF2 and PBKDF2 is a bit of a mess because, you have this constriction to
find a Fibb document but you need to use a PRF sort of a rendering function and
inside this thing you have a hash function. Usually use PBKDF2 to H mark SHA1,
so you use SHA1, you use something called H mark, and you use PBKDF2 and I've
seen most people use it because sometimes just for compliance.  Because you have
to stick with standards, and I could say what is much better than these two is
Scrypt. You know Scrypt...

**Randall**: Well actually hold on a second. About PBKDF2, I've used that quite
a bit and for instance like the Python world it's like a really popular Django
framework and a lot of frameworks are sort of standardized around that even
today first of, but PBKDF2 is like a really fast algorithm to compute isn't it?
It's not like, it doesn't take a lot of CPU cycles to compute or anything, does
it?

**JP**: Well it depends on how many iterations you set and the problem is that
sometimes people just get it wrong. Actually cases where you have like 10
iterations, which is like nothing, even with like a hundred iterations it's like
way too fast and I mean you're not a cryptographer how many iterations will you
choose, a thousand a million?

**Randall**: What about the memory cost of PBKDF2, does it require memory to
compute hashes as well?

**JP**: No, that's the problem, it's zero memory so it's the same memory as SHA1
so nothing.

**Randall**: Basically if you were to spin up like a million Amazon EC2 servers
and try to crack PBKDF2 hashes, you wouldn't need a lot of memory to make that
work is what you're saying.

**JP**: Right. That's the thing.

**Randall**: Ok, got you. You talked a bit about Bcrypt, so Bcrypt obviously
requires a lot more CPU and you can configure the iterations and stuff with the
time cost factor but it doesn't require a lot of memory. You said four
kilobytes?

**JP**: Yes was enough 20/ 15 years ago but not anymore today, and you can
directly either modify the crypt to make it just more memory you had to design
something completely different.

**Randall**: Where does Scrypt come into play? What's the difference between
Bcrypt and Scrypt?

**JP**: Scrypt was really a game changer in that it introduces the idea of what
the guy called memory heart functions where you can tune the amount memory that
will be used by heart functions. Three months to get designed by the principle
famous *<indiscernible>* and the difficulty is it looks easy say I'm going to
use that memory I'm going to see the huge table of data and that's it.  What's
hard is to ensure that the attackers will not be able to compute the same result
by using that memory.  This sounds pretty trivial when we think about it but when
you try to brand the algorithms it's not trivial at all. I think you got it
mostly right? *<indiscernible>* for my part may be one reason that his script was
adopted is that it's pretty complicated in this same script you use
*<indiscernible>* in the Scrypt design in *<indiscernible>* use another password
hash.

**Randall**: Out of curiosity when you implement stuff like this how does one
actually implement memory hardness. You know what I mean like how do you
actually develop algorithm that requires large amounts of memory that actually
generate hash? What's the basic foundation there?

**JP**: The code is that you want to content and the memory to be unpredictable
and also the addresses of where you will put the data because if very typical if
an attacker can be predict it he can pre compute it can make it like a
*<indiscernible>* won't like to locate the big chunk of memory and to put some
random looking data at random looking places do in short.

**Randall**: Got you since Bcrypt doesn't really require enough memory to be
sort of useful with modern attacker against one attackers and Scrypt is overly
complicated and never I guess caught on as much. If people are storing their
passwords are storing their password hashes currently using Bcrypt or Scrypt do
they need to be worried about those hashes getting compromised in the near
future.

**JP**: It depends on probably not if you get the right permission for script
then your fine if you get the implementation right and your fine too. I think
that's what tampered that option of script is how to pick the right parameter
for your application there different values to select and from my experience
it's not very clear. Even cryptographers, how you should make this choice
that's pretty why people ended up picking just stupid hash functions like Sha1.

**Randall**: All right we going to take a quick commercial break and when we
come back we're going to talk about the hashing competition you run about the
new Argon2 hashing stuff and then about some other cool stuff stay tuned.

**ADVERTISEMENTS**

**Randall**: Okay welcome back we still got JP here we're going to talk a bit
about the password hashing competition first. JP tell us a little about the
password hashing competition you run and why you started and sort of what
purpose of that is?

**JP**: Yeah how it all start I think was from 2012 I was chatting on Twitter
with a bunch of people about how password hashing sucks people don't because
down use Scrypt because of this *<indiscernible>* sucks because doesn't use
enough memory and this hashing competition by NIST had just finished 2012 I
was like okay guys what about stopping criticizing existing and create something
new. What about running competition this principle public the competition like
SHA-3 where people submit theirs IDs for free everything is public people try to
break them and at the end of that the organizers pick one or more. Surprisingly
people were very enthusiastic about the ideas so I get some of the people
together to form a committee, a technical panel and we started writing a code
for submission that we publish Q1 2013 that's how it started.

**Randall**: Cool also because I think a lot of people aren't actually that
familiar with how this sort of standards and stuff get generated but this is
pretty calm security issue the way people typically develop this hashing
recommendations is by running a competition is that correct?

**JP**: Yeah I think that's way better than having a consortium for example
design by the committee thing.

**Randall**: Typically how does this work so like you run a competition how
many, how do people sort of find out, do you sort of evangelize by yourself you
talk to universities, how do you get people interested?

**JP**: What we did we open the competition for everyone and typically if you
look at previous competitions of submissions for basic types of organizations
we've submissions from academics, from universities, from industries and
sometimes from government institutions.

**Randall**: The government sounds a little scary. Did you receive any password
hash submissions from NASA or anything like that?

**JP**: No we did not but in the previous competition in SHA-3 for example there
was a submission by people from the French different *<indiscernible>* or
whatever we are very open to our *<indiscernible>* and also everyone can try to
contribute by analyzing the functions trying to brighten implementing the
functions. Even in the committee we've people very different profiles I want work
on this not just current mix like people from the real world software engineers,
people who crack passwords even to have someone from the US government have met
them from their eastern. It's only by having this diversity that at the end of
the day you'll get something relevant and useful.

**Randall**: Yeah that makes perfect sense I guess just thinking about the soft
term I had but it seems to me you might run the competition you get a lot of
different submissions and stuff. How hard is it to actually analyze all these
things, how long does it take, how many people are involved? How do you vet the
quality of the crypt analysis work I guess?

**JP**: Yeah it's kind of *<indiscernible>* because we don't organize like you
guys can look at this one, you guys can look at this submissions. What happens is
that people issue try to break the submissions that look easiest to break
*<indiscernible>* all the ones that are the easier to analyze but this sort of
natural selection. Because submissions that look complicated don't get very well
analyzed don't get a lot of confidence best case is that when submission that look
simple, looks *<indiscernible>* very appealing to everyone and many people try to
break it and many people fail to break it that's the kind of algorithm we wanted.

**Randall**: That's cool another question too when people submit their
algorithms into the contest and stuff are there rules about what language it has
to be implemented in and sort of standards on that line or sort of anything
goes?

**JP**: Yeah everything mister.

**Randall**: Everything in the list parenthesis all over the place.

**JP**: That was one of the criteria and the call for submission who said how to
meet basic requirements we want a hash function, why you can take this input and
output why you can do the memory and so on and also wanted some reference code.
We asked for code but it was simpler, it was interesting compared to the
previous competitions I've been involved in. Is that previously it was mostly
bunch of people I got to meet so who would write a very clean specification
using  LaTeX formatting, fixed pages and so on.  Those guys know really how to
write code very well if you look at the C-code *<indiscernible>* and for password
was a big difference. We've some people who aren't familiar in always writing from
a specific channel always mathematical C-code and just send in some code for them.
The specification was the code because they were much more comfortable coding we
also have to face with different profiles people more got up or people more
mathematicians.

**Randall**: That's actually really interesting I guess I always assume that
when people did the submissions it was just code but you're saying that people
also submit mathematical proofs and stuff as well?

**JP**: We're in as much as documentation as possible and people to explain to
us why they created the algorithm the way they did, why they choose to have
additional sort of *<indiscernible>*, why did they choose this parameter give
the designer rationale and sometimes the more academic submissions they even
came if security proofs. Security proofs means that under some assumptions
you've mathematical evidence that it takes I don't know at least this amount of
memory to complete this function for instance, we receive submissions of 50
pages and some others of two pages.

**Randall**: That's crazy how many of this did you personally take a look into
and try to break and stuff like that?

**JP**: I looked at all submissions because I had to it was always not easy.

**Randall**: That's crazy how long does that take? How much time would you spend
auditing one of these algorithms for reference?

**JP**: To start with you can really make superficial analysis just understand
just how it works. Sometimes it will turn out that the specification was
specifying something and the code was doing something different so you have to
find the differences between the code and the specs. The first stage which
you've to look for the biggest mistakes or submission that will obviously not be
winners and try to find good reasons to explain to your designers it will not
make it.

**Randall**: Did you ever find yourself just looking someone's code and saying I
can't believe this guy is a programmer?

**JP**: Yeah people have different levels of expertise and sometimes it's really
funny but we try to find positive points in each submission and sometimes you've
a very amateur design but you've this original idea nobody had before and you
want to say algorithm is a great idea but the whole design isn't so mature but
there's something to work on here.

**Randall**: Interesting one other thing too I forgot to mention this earlier
but where did timing attacks play into this stuff. When you're running this
competition did you guys spend your time analyzing like if you're comparing two
strings that they've the same amount of time it takes to compare each one
something like that or it that plain invisible.

**JP**: Yes that is one of the big questions that we discussed is first of all
should we care about the timing attacks depending on the application it may or
it may not be relevant. You said idea is that depending on password that you
hash or side of the password that will take different time. Marginally we're
talking about side software attacks to casting your attacks. We have two types
of submissions the submissions that don't care about any attacks and other ones
that make some effort to be resistant to this kind of attack and that came with
some computing arguments.

**Randall**: To elaborate on that a little bit since the competition you're
running was specifically geared toward passwords hashing algorithms, do you do
timing attacks matter in your opinion for that stuff or is it not really not
important for password hashing?

**JP**: If you hash like on a local machine, if you use a hash to enter the
password for your full encryption scheme if make sure no one is running on your
system or hardware but if some Cloud System you don't know, you don't put in the
same *<indiscernible>* and this may be an issue eventually what we do in the
winner we'd one version that's timing safe and one that's may be not. The
challenge here's that if you make sure that it's acting on resistant then you
can be optimal secure against another type of attack.

**Randall**: Interesting it's a trade-off there.

**JP**: Yes trade off but just need to be good enough on two sides and if you
could this was good enough.

**Randall**: Got you okay cool yeah sorry to go off topic but just popped in my
head and was really curious about it.

**JP**: That's fine.

**Randall**: The contest just wrapped up recently right a few months ago I
remember exactly and you guys basically all collectively decided that the winner
of the password hashing competition was the Argon2 algorithm right?

**JP**: Yeah.

**Randall**: Let's talk about that, first off why did that win and what's the
close call was it hard to make that decision and what makes that algorithm
really special? Why was that really sort of selective in the submission?

**JP**: Let me tell you taking this kind of decision isn't easy especially when
you've so many different people and so much good submissions. The thing that you
should know that Argon2 was initially not submission to PHC there was something
called Argon1 and Argon2 came later and it designed that leverage a lot of
decisions we had that we also learn from our submission.  In the middle of the
competition when we selected the finalist so a short list of nine algorithms we
selected algorithm was created by Cadelics from Luxembourg, Alex Biryukov,
Dmitry Khovratovich, Daniel Dinu we allow the submitters to tweak their
algorithm a tweak means a minor change and came to us and said we've this new
version Argon2 and we're like okay but it's totally different from Argon1.  It's
too much different to be called tweak may be we don't want to get this in the
competition but later on people were arguing Argon2 is very good it would be
stupid not to have it just because too much different. Obviously some other
people were arguing it would be unfair to other competitors were not allowed to
make this kind of change.  Eventually we picked Argon2 because I think where it
stands out is really its simplicity. It's like when your programmer you try to
solve the problem the first thing you do you write some messy code you don't
refactor your code but you get your job done and the hardest part is to make it
as simple as possible. Simple means easy to analyze, easy to implement something
faster too and I think that what Argon2 learned from the competition process
they made something very direct in design and very well understood, very well
motivated and actually it was quite obvious to us that that was the way to go
there were some other very good submissions but we just felt that it was the one
to mostly likely to get popular among users.

**Randall**: That's really interesting and well cool I guess it was really hard
decision to make like who was the runners up, who was the second algorithm you
guys was sort of considering against it?

**JP**: There's no single second there four which are called Catena, Lyra2,
Makwa, and yescrypt we called them special recognition to say that these are
really good. They're very innovative some of them but we've a single winner who
wants a simple message this the winner. We're discussing whether or not to be
should different winners but we thought it could be more effective to have one
winner and four others, four which we say these are very nice, they're secure
you may want to use them but we don't do all the support and maintenance for
these guys because.

**Randall**: I think that makes more sense too so people like me who like
unnecessarily crypto experts can take a look and say this is the best one you
guys selected and that's the one I should use.

**JP**: Yes the fewer choices you ask people to get, the few chances they have
to make the wrong choice.

**Randall**: Yeah for what it's worth I think that was an awesome idea because it
makes it way easier for normal developers to follow through those
recommendations. Okay let's get a couple more questions about Argon2. Is Argon2
CPU intensive and memory hard like Scrypt?

**JP**: Yes, due to dimensions of time and space you can choose how to store it,
how many operations it will make in the CPU and how much memory in terms of
kilobytes. You actually give the actual number of kilobytes that you allow them
to use.

**Randall**: That's cool -- that's even more configurable that Scrypt is
right?

**JP**: Yeah, just much more intuitive to users and don't have to compute
again I use *<indiscernible>* so how many megabytes I need and there's a
third parameter which is part of like if you have a machine with eight cores you
can *<indiscernible>* in a day just your eight cores to compute Argon2.

**Randall**: That's awesome, so a bunch of questions about this, if people
actually want to start using Argon2 in their applications. Let's say I'm
building a website and it's storing sensitive information and so the passwords
are really sensitive to me. I start using Argon2. What are some sensible
defaults that should be set for the algorithm? Are there any official
recommendations about what people should be using, or is it sort of
completely variable?

**JP**: In terms of parameters?

**Randall**: Yeah like how many iterations, how much memory is safe for someone
to use etc?

**JP**: The first choice you've got to make is actually what version of Argon2
to use. One of them is totally safe for side channel attacks: Argon2i, and
another one that's not totally side-channel resistant: Argon2d. You first have
to decide whether or not you want full side channel protection or only partial
side channel protection, and then the document which process to use for users
to make the best choice of parameters. We have some examples of parameters but
then we have some benchmarks for you to test on your system. So you're going to
try Argon2 you'll see how much time it takes and you'll have to figure out
what's the best for you. How much time do you tolerate it because it depends how
many hashes you do per rate of time, how many users you have, what kind of
hardware you've got.

**Randall**: Let's start with distance since most of the people listening to
the show are web developers building web applications and what not. What is
more important, is it more important to have side channel protection or is it
not that important for web apps, and specifically keep in mind that for web apps
at least in my opinion, one of the greatest vulnerabilities isn't that people
are going to brute force it through a website. But more like the database gets
compromised and all the passwords hashes are leaked?

**JP**: Since it depends on how you deplore your application if it's on a shared
cloud or if it's your own system but I would recommend may be to be on the safe
side to be side channel resistance. May be even for some marketing resistance
sometime, people who say you don't use section version it's not extremely costly
to use the side channel safe against the other one better take the safest option.

**Randall**: Basically the recommendation is to go Agorn2i correct?

**JP**: Yeah.

**Randall**: Okay cool that's really useful for people to get their
recommendation. If you had to give some advice to a web developer like right
now who is building a new application what would you tell them you need to know
before they get started plugging Argon2 into their site?

**JP**: First thing I would tell him don't implement Argon2. We've got some
reference code on GitHub and hopefully the plan is that this will be the reference
implementation of Argon2 with working we've got a lot of under code. We're using
a new complex piece of code there's always *<indiscernible>* things to improve,
a lot of things to make it more professional, more maintainable to have a lot of
people who send issues in pull requests. And we're still working to make it as
much as possible we're going to get a new release soon but the bottom line if
you can reuse this library we've wrappers for many languages Python, Node and so
on. First try to use it for reference code and if you'll need to implement
yourself. But check out our page it's you look for PHC on GitHub or you go to our
website password hashing, password-hashing.net and you'll find all the
information you need there.

**Randall**: Cool and also that official C implementation you're talking about
is that available in all the big Linux and UNIX distributors currently or you
guys are working on that?

**JP**: *<indiscernible>*

**Randall**: Is the C implementation of Argon2 that you guys have up on Github
is that packaged up for different Linux distress yet like Debian and Red Hat
and stuff?

**JP**: It should combine all the user operating system, all the Linuxes, all
the VMs or Windows. We're working to integrate it in Debian, someone's helping
us a lot on this. The library at this stage should be visible but may be one
warning is that you should wait may be a couple of weeks at least to put in
production, because we may still make some changes that will break backward
compatibility if you care about it.

**Randall**: When people listen to this it probably going to be early February when
should people start using Argon2 in production in your opinion?

**JP**: We'll communicate the changes soon because there has been a research paper
that was published recently that points out some sub-optimal, these are issues in
Argon2 not big problems. But I was chatting with designers for Argon2 recently.
And they say that they want to make some changes to make Argon3 even better. So
they will make this I guess in the coming weeks there is an internet draft.
There's description on augmenting this about, starting this standardization
process. We're still trying to totally freeze the designer this quarter hopefully
and then the décor in this space will be... We're going in a more *<indiscernible>*
We want to have the best hash we can create; we don't want to rush this process.
So maybe I would advise people, to wait some months and if February things would
have settled down and we'll have finalized the function.

**Randall**: Awesome, so if you guys are listening to this and you want to go and
check it out, be sure to check out the Password hashing competing GitHub page, and
the Argon2 page to get more information, right?

**JP**: Yep.

**Randall**: Cool. Well I think that's about it for Argon2, just to sort of wrap this
up, but what stuff are you working on now? You got anything interesting in the works,
that you want to share with anyone?

**JP**: Maybe one big project that started last year is a book, I'm writing a book
about *<indiscernible>*.

**Randall**: Awesome.

**JP**: Yeah, I'm very excited about this, it will probably be called Crypto For
Real because that's going to be a document from the all the creative books I used
to. It's going to be used as a guide, it's going to be an academic text book, For
Real is for real applications and for users. What I notice is that people sometimes
use Crypto or read stuff about a Crypto, but they don't really get... They grow a
concept with the abstract ideas behind what they're doing. So they might remember
some guidelines, some reasons, but they don't know why they made these good
choices.  Like I will have two parts where I will explain first the very basics,
randomness, cyphers, hash functions, public Crypto and then go on talk about all
the modern applications of Crypto. Like what we hear every day, like
*<indiscernible>* analytic networks like *<indiscernible>* obviously, seek your
voice and all the stuff and Bitcoin too.

**Randall**: Awesome, so when can people go check that out? Do you have any
dates planned or are you going to try launch it this year or?

**JP**: That's a lot of work but hopefully we will publish some chapters this
year. Already I'm discussing with my editor, but we'll try to publish some chapters
for free on the *<indiscernible>* website.

**Randall**: Awesome well I'm going to go on record as saying, I'll be the first
person to buy a copy, so let me know I'm going to order one.

**JP**: Great.

**Randall**: Okay, also because people are interested in this stuff, but are you
going to run another password hashing competition in the future do you think?
And if so do you have plans for that?

**JP**: It's no *<indiscernible>* I think there is already another competition
that's going on us called CAESAR, C-A-E-S-A-R and it's run by Dan Bernstein.
It's about authenticated cyphers, so you know cyphers why are you not encrypt but
also authenticate. You can check this out online there's many submissions too and
plan definition 2017. And maybe one use is that they will probably be another
competition organized by NIST people are hearing all this post quantum thing.
We've thought about NSA who is advising people to switch to algorithms that would
be safe against quantum computers. Just in case quantum computers show up in I
don't know 50 or 100 years. So I've heard that there may be a kind of competition
related to this, I don't know when.

**Randall**: Interesting, that's really cool. And also you just gave a talk about
that recently to in DC, right?

**JP**: Yeah, *<indiscernible>* I talked about *<indiscernible>* what does it mean,
and should you care about this whole thing and will quantum computers be built? So
I don't know but there is some common sense issues here, where you have to focus
your investments because the NSA wants the government to start thinking about
switching to post quantum stuff because it takes years to debug and use a cypher in
a government applications. Does it take maybe 20 years and it takes 30 years, it's
due for 30 years. It was very long time *<indiscernible>* ask and maybe a lot of
time but they may be right about that.

**Randall**: Very cool, and lastly I think a lot of people would be interested in
this in particular. There are a lot of new developers out there who really want
to get into like the security industry and really want to get into Crypto and
make the internet a safer place. So since you're sort of a really well known
guy in this area, do you have any recommendations for new developers who are
trying to get into this space? What advice do you have to this people?

**JP**: You should get into CSSP and then set up. The Crypto and CSSP are very
funny. More seriously I would say in Crypto today there is a lot of resources to
learn from online.  But I think one major deference between people is I think you
need to understand the abstract concepts behind what you're doing. Like what's
PRNG?  What's a one way function? What's *<indiscernible>* function? And as
usual when you design security system, look at the whole system and think about
the straight model. Because I think many times people will say, all right I
want to make it secure so I'm going to encrypt this.  That's like good, but
why do you want to encrypt this, it doesn't make sense. It will be more secure
and I want to use a PTI. But why it would make sense to... It will introduce
even more weaknesses, it will introduce more extra phase. So I think to think
about the security, you need to understand the whole thing, the big picture,
to understand straight models to understand different types of security
notions. So I think that's a lot of work but you need to get it right before
implementing your thing and choosing the fancy cypher because of the new
recommendation.

**Randall**: Awesome, well I think a lot of people find that useful. So hey
JP thank you again so much for being on the show man, I'm sure people are
going to find this super useful. And thanks for doing all the cool stuff
you've been doing to help make the world a little bit of a safer place. We
all really appreciate the work you've been doing man.

**JP**: Yeah thanks men, that was great, thank you.

**Randall**: Awesome well, that's it. I'm Randall Degges; you can find me on
twitter @rdegges. JP why don't you tell everyone where they can find you,
twitter, email, website, Facebook whatever you want.

**JP**: They can check my website aumasson.jp, you can find me on twitter
@veorq. *<indiscernible>* that's a bit of my name, CEASAR.

**Randall**: Awesome, well thanks again men, appreciate having you on and
we'll have to catch him again in the future, thanks so much.

**JP**: Thanks.

**Randall**: All right take it easy, bye.

**ADVERTISEMENTS**
