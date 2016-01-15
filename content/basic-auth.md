---
date: 2015-11-02T17:16:36-07:00
title: 0x01 - Basic Auth
image: /static/images/casts/bouncer-sketch.png
cast: http://traffic.libsyn.com/thestormcast/stormcast-episode-0x01-basic-auth.mp3
summary: >
  OMG. I love HTTP Basic Auth. More than my own children! (*I kid, I kid.*)
  But seriously. Basic Auth is awesome. In this episode, we'll talk about why it's
  cool, and how to use it for the greater good.
---


**Randall**: What's up everyone, welcome back to episode one. This is our second
episode, our first episode was episode zero. This is episode one of Stormcast
the pod cast where we talk about web security and other cool shit. I'm your host
Randall Degges and today I have Robert Damphousse with me. What's up Robert?

**Robert**: Hey guys.

**Randall**: It's also the day before Halloween, so happy Halloween to all of
you guys out there. Yeah so Robert is our guest today. He's the head of
JavaScript at Stormpath. He's also a really good friend of mine and knows a
bunch about authentication and security and building fun web apps. This should
be a good interview. The topic today is basic authentication. HTTP basic OAuth
has been around for a while. It's sort of known in issues like the simplest form
of authentication out there for web stuff.  In this show we're just going to
sort of dive into that and just have a casual conversation where we talk about
you know what basic auth is, should people still use it. It's been sort of
going out of style lately, so we'll get into that a little bit, and that's sort
of game plan. Before we get in to things, tell me a little bit about your
history just so all the listeners can get to know you a little better.

**Robert**: Hi everyone. I'm Robert head of JavaScript here at Stormpath, yeah
head of JavaScript. That basically means I've been doing JavaScript for a long
time. I was thinking back just now on when I started doing JavaScript. I'm
actually not entirely sure. I actually think in might have been through doing
like Action Script or something. That was my first introduction to a language
where the rules are not quite defined and maybe things work maybe they don't
work.

**Randall**: That's like the most accurate discussion of JavaScript ever like,
sometimes it works and sometimes it doesn't.

**Robert**: Yeah, it's kind of managing the chaos. It's getting better, the
JavaScript ecosystem has evolved quite a bit, to the point where I can do it
full time, which is kind of cool. Yeah, I could talk more but...

**Randall**: Well, just tell us a little bit about what you're working on now
and what sort of things you're doing for work. I know security is a big part of
your job since we work together obviously. Just tell people a little bit about
that.

**Robert**: Yeah. At Stormpath obviously we're super mindful of security because
we're dealing with user data. Everybody wants that to be secure. Dealing with
security in a browser is a very interesting world to work with because you often
times just research in tradeoffs and trying to make the best kind of
architecture decisions based on the environments because there are many
different browsers and whatever. Yeah, it's kind of like an interesting like a
last mile security problem. We can architect the APIs and everything to be super
secure, use SSL sorts and all that. But then there's still this last little bit
of making sure the browser is secure and used properly. It's an interesting
challenge, I like it.

**Randall**: Also for you guys out there, Stormpath is a sponsor this episode. A
huge thanks to those guys for sponsoring us. If you're not familiar with
Stormpath, basically it's an API service that stores user accounts and handles
authentication, authorization, data encryption and stuff like that for you
users. Robert is essentially in charge of all the JavaScript libraries here. He
actually builds authentication libraries every day and make sure people's apps
are secure and happy and stuff like that.  Anyways thanks for the info there.
I'm sure people will find that useful. Let's start talking basic auth man.
First off just tell people who may not be familiar, what is basic auth and
what's just the high level of it.

**Robert**: Okay your first experience with basic auth is probably using some
old school website, probably published by a government and the application all
of a sudden throws this log in screen at you that you're like 'where did this
come from?'

**Randall**: Yeah like with that little pre built Chrome or Firefox popup
window, part of... It's not part of their UI, it's just like you get that
fucking pop up you can't close out of.

**Robert**: Yeah. I mean the reason why I bring that up, is because most people
have probably had that as their first basic auth experience and didn't know it
and be like basic auth is so old. It's part of probably the HTTP 1.0 spec if I
remember correctly. It's this mechanism by which through the HTTP requests
response. Where you basically say, hey you need to authenticate give me some
credentials. Then there's a structured way that you pass basically. We call it a
user name password. I'm not sure if the spec calls it that.  The idea is you
have something short and then something long that's supposed to be like a
password and you pass it along to authenticate your request. It's just like it's
a very simple form of authentication that's codified in a spec, so much so your
browser has a default window for it and it looks kind of ugly.

**Randall**: It does look really, really ugly. I remember for me anyways that
was how I got started with basic auth. I think way back in the day in, let's
see maybe in middle school, my brother and I built a website for our school. We
were using Apache and htaccess files to control who can long in to the site. We
literally just put usernames and passwords in there. When you go into the site
you have to prompt put in those crappy browser prompt.  Yeah, so the basics of
basic auth is that it requires some username and password, those are loosely
require obviously to authenticate. Specifically, how do you supply those? What
header fields are they going to? Just tell people a little bit about that.

**Robert**: Basically the idea here is you supply a header called authorization.
Then you give the username and password with a colon in between the two, and
then whole thing has to be Base64 URL encoded. URL encoded, which is different
from Base64 encoding. If you haven't run into this range, you will someday.  I'm
just laughing thinking about the time I lost on that one. Yeah, so you put in
the header and then the server is supposed to look for the header on incoming
requests. In the case of unix for example go look it up in a file or a
database or whatever. That's pretty awesome. Does that mean when people wanted
accounts, they had to come to you specifically and you're like have the text
file.

**Randall**: Exactly yeah. We would literally ask people if they wanted an
account on our school website and then we'd type their username and password
that we generate for them into a plain text file and then it to them on a piece
of paper and be like, check other awesome website, it's this-ip-address.com.

**Robert**: Yeah, so that would mean this is the environment that basic auth
came from. There's a world where computers weren't that cool yet. You had to go
talk to a guy to get an account on them if you were so nerdy you want an account
on this system.

**Randall**: Okay, so next up so obviously basic auth is super old. I think
it's been around since '96 or something like that. It's been around forever.
People obviously still use this thing all the time today right. We're both
developers we use API services a lot. There's lots of API services that operate
completely on top of basic auth. It's not completely dead. I just want you to
take a minute and just explain why is it still around. Is it too old to be used?
Why do people still use it? Just your opinion whatever.

**Robert**: The answer here is like a space gear like HTML tables. It's still
around because it works. It works and it's great. It's just really simple like a
username, password, ID, secret or whatever you want to refer it as. It uses a
very common part of HTTP. You supply this header and then you just read the
header. It's still around because it's super easy to use and because it's just
using basic HTTP stuff most of our favorite HTTP tools; be it cURL or whatever
your favorite HTTP libraries is in your environment it's got... It's built in
support for doing this easily. When you're using your convenience libraries of
HTTP you just kind of assume you should pass username and password and things
kind of just work &copy;TM. That's happening because basic auth is so simple
basically.

**Randall**: All right, cool thank you. Next let's talk the security of basic
auth a little bit. I know that you in particular are super familiar with all
the different authentication protocols including OAuth authorization protocols
like OAuth 2 or OAuth 1 stuff like that. Let's talk about OAuth security.
Let's say... Or actually let's talk about the use cases first. I think it's
pretty obvious that nowadays if you're building a website, you never ever want
to use basic auth to a lot of people right.  Just because you don't want that
fucking annoying browser pop up window. It just looks ugly and it's horrible. By
the way real quick I'm going to call someone out right now. The Python Packaging
Index pypi.python.org the place where you go to create packages and stuff uses
basic auth for log in. We're both laughing because I'm pulling it up on my
computer as we're recording this episode and it uses basic auth and it's
October 30th of 2015.  I'm calling guys you out; you need to fix that shit.
Anyway so I would just go as far as to say if I'm building a website, I will
never use basic auth to log people in on a website. Do you agree?

**Robert**: Yeah. I really doesn't... I mean the irony of it is that it was built
for websites, but these days it doesn't make sense. Because when was the last
time you built a website and didn't want to completely customize the look
and feel of your log in for it. There's really no reason to let the browser
just pop up this very generic form. Yeah, it's kind of dead for browser
purposes but ironically picking up for API services.

**Randall**: Yeah which leads me the next thing. I feel like, at least for me
I'm a huge fan of basic auth just because of how simple and straight forward
the spec is. You have some username or password usually it's hopefully not your
real username and password for your service. Usually it's like an API key or
some random strings right. I like it because it's really simple. There's lots of
programming language libraries out there for it. You don't need anything else
other than this password to get access to stuff.  More importantly because if
you're building an API service right, you have to... APIs are stateless. You don't
have a session like you are on a browser. You have to supply credentials with
every single request no matter what. You have to do that in some way and so to
me basic auth makes sense for a lot of API services just because it's sort of
intuitive. If I give you my API keys, you know who I am and you can say yes you
can access API service or whatever. Back to the security part of it again, I
lost track a little bit there calling people out and stuff.  Talk a little bit
about the security of basic auth. Just cover some of sort of the issues people
brought to light over the last few years. What things you should sort of do to
keep things secure like SSL and what not and just talk a little about that to
the listeners.

**Robert**: Like any username and password exchange, you're basically sending
the stuff, plain text over the wire to the server right. Obviously this day and
age where everybody including the government is spying on us, you needed to use
HTTPS between... And even better distance SSL layer between your client and your
server. That's like the best thing you can do for like security wise, is just
make sure that that channel is secure. Because like Randall said when you're
using that stuff for an API service, you're going to be sending those
credentials every single time.  You need to ensure that that communication
channel is secure. At that point you can kind of just rest assured that things
are working. The only other thing I would suggest checking is to make sure that
your server isn't logging the entire HTTP header somewhere or it's easily
accessible with some passwords that my secretly database with like root and root
for username and password; that kind of stuff.  Just make sure that stuff
doesn't get logged somewhere. Yeah, so that's where you need to start with
security for this authentication mechanism.

**Randall**: Oh, so a follow up question here. You know we talked about OAuth in
the last episode, and basically the way OAuth works for API services at least is
people are going to exchange some API credentials using basic OAuth essentially
for an access token. One of the benefits of the OAuth protocol and particular
the client credentials exchanged type or grant type, is that instead of
resending your actual, API credentials over the wire on every single request
instead you're sending this access token which is a little more generic.
It's not really as insecure necessarily right. Could you just elaborate on
that a little bit?

**Robert**: Yeah, so when you start to compare basic auth to other schemes like
this OAuth credentials scheme. The benefit of the OAuth situation is yeah, you
do this initial exchange of what I call the hard credentials; the username and
password. Then you get back this access token which is just still giving you
access to the same resources, but it's a little lighter because it's usually
scoped either by resource type or by time. The most I think the default most
people use is that a token is valid for an hour and then you have to refresh
new ones.  It helps you to do damage control a little better. If you know
that a particular user or a particular network connection is compromised,
you can basically immediately revoke all the tokens and then be like let's
see how big the problem is right. Then if you need to, you can revoke
everybody's APIs keys. Because nobody wants to have their API keys... Their
username and password revoked if they don't need it. The tokens kind of give
you this first kind of like femoral layer that you can do damage control on
before than just straight up provoking everybody's keys.

**Randall**: That also adds a lot more complexities well right. You know if
you're building an API service and you're just building some service that apps
will talk with it. This means you have to manage your access tokens, you have to
handle the expiring time, you have to handle the refresh token grant stuff. It
becomes significantly more complex right than just a typical basic auth flow. I
guess my question for you and also so going back real quick, considering that
regardless of if you're using basic auth or using OAuth you absolutely need, no
matter what else you do, you absolutely need to be using SSL between the client
and the server.  That's because even if you're using OAuth you have this access
token and you're going over plain text someone can just  basically man in the
middle of your connection. You can be on the coffee shop Wi-Fi or whatever, grab
your access token and start making request on your behalf until that token
expires. I think the question is since everything is over SSL, is there really
any difference in security bit between these two anyways? Does this really
matter so much?

**Robert**: Yeah that's a good point. When you want to focus on just security
hard credentials or access tokens yeah I mean you can argue that it's a bit of
mid-point as long as you have SSL on the connection. From there I would take the
conversation and talk about authorization because OAuth provides authorization
things that are cool that basic auth doesn't do. If you have a really simple
use case where username and password essentially gives you full access to
whatever this API resource is. It is definitely simpler to use basic auth, but
I don't disagree with that.

**Randall**: All right, cool. Then I guess the next thing I had on my mind is
like nowadays on the internet if you're checking out a stalk full of questions
or whatever, what I see at least most of time is people asking how to use OAuth
and what is or how it works or whatever. I really see questions about basic
auth. To me it seems just based on communities online and stuff. It seems like
basic auth is sort of dying out and OAuth and JSON Web Tokens and stuff like
that are sort of all the new hotness.  I guess my question is do you agree with
that? Then if so, sort of explain little bit why. Why is it going out of style
even though it still is most likely equally secure if you're using SSL and all
of the things considered.

**Robert**: Well my guess is nobody is asking about basic auth because it just
works. There's no problems. It's probably why, but yeah I mean there's
definitely a lot of hotness around OAuth and JWT access tokens right now because
it's like anytime there's a more complex solution that sounds cool, everybody
wants to do it. I don't know why that is, but we like to do that. There's
legitimate use cases and it's mostly around authorization because that's what
OAuth calls itself right?  Is it authorization framework? They kind of don't
actually talk whole lot about the authentication piece; they just assume that
the authentication is kind of happening somewhere right? As far as we know
authorization framework, it's got some cool ideas. The idea that you present
some credentials and get back a token which is scoped to a particular resource.
I think the reason why we're seeing this particular solution take off, is
because I think people are looking for an authorization solution because so many
things we're building now are Multi-Tenant applications or applications are
really becoming like a steward of a user's data and because it's a service
oriented world now that a user may want to share a piece of that data with some
other service.  It's like we're entering this world where we're hosting people's
data and they want to selectively share how it's used with other services. It
begs the need for some kind of scoped authorization and OAuth has attempted to
address that. I mean we can argue how well it's done that, but so far it's like
the biggest one that has a spec that people can argue about. That's why it's
going to get popular.

**Randall**: Let's change topic slightly here. I think this is actually where
things are going to get sort of interesting because I know we have slightly
different views here, but essentially there's obviously different use cases for
something like basic auth verses OAuth right? They each... What's the easy way
to say it? They each have totally different strengths. OAuth in particular is a
really flexible authorization protocol. You can have variable scopes and
permissions that users must accept. You can have token that expire. Well that’s
sort of more a JSON Web Token thing, but whatever we'll lump them all together.
It can be used in more use cases. Like you can use it to authenticate third
party developers. You can use it to authenticate angular finite, stuff like
that, mobile apps things like that basic auth is just not really built for.
Let's talk about the use cases. Why and actually I just thought of this as I'm
saying this out loud here, but why for instance can you not use basic auth to
authenticate something like a mobile app or an angular finite? Let's talk about
that too, because the more I'm thinking about it now the more I feel people
should know more about this.

**Robert**: Okay, this is a good point. You don't want to use basic auth in
mobile clients or finites because you're exposing what is supposed to be
confidential credentials to the world. If you create some angular app that's
consuming some API and you put in the API credentials, the username password in
the angular app which you will have to do in order to let that angular app
authenticate with the server. Then anybody can just view source the web page and
get the credentials out.  It's the same with mobile apps right, you can just get
the app binary and run it through some tool to decompose it and get the keys
out. That's where basic auth kind of breaks down. It's kind of the same problem
of just generally storing a user's username and password. Nobody would ever
create a website or an angular app where they ask for username and password and
then store in a cookie so that you don't have to ask to a user for it next time.

**Randall**: Oh, don't say nobody.

**Robert**: Okay nobody should do that. I'm looking at you.

**Randall**: By the way we're going to have to do an episode at some point where
all we do is spend an hour and a half just calling people out for storing
everyone's stuff in plain text, but that would be in the future.

**Robert**: Yeah it will be an episode of things that nobody should do that you
might be doing.

**Randall**: That's a great title that's exactly what I'm going to call it.

**Robert**: I mean, back on point where basic auth is not good situations where
you need to keep those credentials secure. Which again comes back to the API use
case because usually if you've got just some little server site demo or script
or servers running that needs to authenticate with an API, it's pretty assumed
you're running that on some kind of secure server environment where you can that
the username and password in the environment but it's not going to get leaked to
the outside world.

**Randall**: I'm just going to attack a little bit on to what you're saying
there too, but another use case in which you should never use basic auth, and
this is one that's I think pretty important. Let's say, I'm just going to throw
an example out there. Let's say that you're a developer right and you want to
build an application that works with someone's Google account... the Google log
in account right? Google does not support basic auth for any of their services.
If I go into my Google account dashboard or whatever, there's no way for me to
generate an API key and use basic auth to access stuff.  One of the reasons
why, is that if I'm a developer building website like mycarwebsite.com or
whatever, and I wanted someone to log in or give me access to their account, I
would have to tell them, "Hey either give me your core Google username and
password to access your account, which is like you don't want someone else
having that, or you'd have to say generate an API key and give me this API key."
Which is essentially the same thing because you're basically giving someone else
root access to all of your stuff. In use cases like that where you have these
three-legged flows, you really need the OAuth protocol to make this sort of
thing happen securely. I'm just throwing that in there too. With that said, I
actually have a theoretical question for you here. We were talking about this
the other day so you're familiar, but one of my *indiscernible* I
guess that I like OAuth for certain things so for instance like Twitter. I think
Twitter is a great example, they use the OAuth protocol and they use it
exclusively.  If want to build a Twitter app and have other Twitter users log in
and access is it, then essentially I need to redirect my user to the Twitter
website have them log in, have them accept permissions from the application and
then Twitter will basically give me temporary access to this user's account and
that makes sense. However, for myself, if I want to access my own tweets through
the Twitter API I basically have to do the same exact thing.  I have to create
an application, I have to authenticate myself and generate a temporary token and
that for me to just access my personal data is a real pain in the ass. Because I
have to do all this OAuth flow stuff that I don't really want to do. Here's my
question for you, if you were in charge of technology at Twitter or like the
head of the engineering team or whatever you want to call it, would you make me
happy and basically add basic auth support for people to access their own data?
Not replace the OAuth stuff but just add an addition so that way individuals can
pragmatically access their own stuff in a simpler way. Talk a little about that;
why and why not and it will *indiscernible* a bit.

**Robert**: I wouldn't do that. It just feels like tacking on an old protocol
when you already you'd have something in protocol that's pretty awesome and
modern. I would instead try to make you happy by making our libraries easy to
use. I don't know if their libraries are easy to use or not maybe you can
comment on that. I would solve this problem through dealing with the OAuth
nonsense and a library level as opposed to supporting an old authentication
protocol when really what I want is just to have an authorization protocol.

**Randall**: I mean like for accessing your own personal data right? There is no
authorization because it's just you. An API key to me is the exact same thing as
your root Twitter username or password. In my mind I think it... Obviously it's
still going to work with OAuth just fine however it makes a lot more convenience
for people to just supply us one piece of information in this HTTP header and
just be able to access stuff without worrying about tokens expiring and refreshing
them and clicking a link on a website to generate this intermediate token and a
lot of stuff.  I guess my question is the reason why you don't like it just
because you don't want these two separate protocols being used. You don't want
to maintain and stuff like that or is there any reason in terms of the security
aspect you're worried about or anything like that.

**Robert**: I mean just mostly maintenance and consistency right. I'm actually
scanning my mind now to I think if there's any security reasons to not provide
root level access to the resource via that authentication mechanism. I can't
really... Again assuming you're using SSL and that you're keeping your keys
secure, I can't see a security reason to not do it. It's mostly a product
decision.

**Randall**: Also you brought up a really good point too. One of the huge uses
with basic auth, is that people will accidentally publish API keys all over the
place. I noticed that... So Amazon web services is a great example of this right.
They provide you with API keys, they don't actually support basic auth per se.
They have their own custom authentication scheme built on digest, but they use
API keys to provide root authorization to your account.  I noted there's a this
GitHub bought out there, they will basically look at GitHub for
AWS_ACCESS_KEY_ID because that what people call it, and will automatically spin
up a Bitcoin mining service on top of EC2 and just give people the hugest fucking
bills in the whole world. That stuff can happen obviously with basic auth if
you're not careful. That's more like human error I guess, but it may be fear
CTO of Twitter doesn't make sense to have that risk out there.

**Robert**: Yeah, that's kind of freaky. People really do that?

**Randall**: Yeah.

**Robert**: Damn, that's like a new level of hack. All right, awesome. Yeah, you
can even with an OAuth scheme you're still initiating the whole flow of
essentially a username, a password or API key parse. You're always going to have
that human element there. One thing that I think is nice about the way some
people implement OAuth, is you have to be really explicit about what you're
asking for. Some services when you do that exchange of credentials you get a
token back by default they give you this really limited scope and then you have
to explicitly say no I want to, access everything in my account.  That
explicitness I think it's cool because it makes people kind of think and realize
that oh right this is everything I better make sure I keep this keys secure. I
like that that is just a little user experiencing I'm guess.

**Randall**: Cool, I think that makes sense. The last thing I to want to discuss
before we take off and grab some food here. Basically for people who are using
basic auth for their API service or whatever right, what are some best
practices people should follow to do this in a good way? I can think of a few
but I'll let you answer you answer first and then we'll just fill in the
details.

**Robert**: Yeah I mean if you're going for OAuth I think the best thing you can
do is, aside from using SSL as we keep saying, is just a little developer
education around how to make sure that these keys don't get exposed to
environment. That they really do need to be kept secure and that's pretty
easy. Just kind of a little info message as they're there downloading the
keys. From a cryptography perspective you should also make sure that IDs and
secrets are really random and not guessable and UIDs. If you want to get
super crazy you can use something like... I know Amazon has services for
generating really unique values and stuff like that.  Yeah, I mean use SSL,
make sure they are not guessable by using strong randomly generated values
and then just a little education to let people know this is giving you
access to everything so don't put these stuff on GitHub because that's
scary.

**Randall**: I'm also just going to add a little bit there too. If you are
building an API service with basic auth, another thing you should also keep in
mind too is, you should always allow you users to have multiple API keys at a
given time. That way you can revoke permissions or the API permissions all the
time. Say for instance let's say you build some API service and you have the
ability to delete API keys and create API keys.  It's really nice because, if
I'm using some API key in my actually application code and I accidentally
publish it to GitHub, what I can do is I'll go generate a fresh one with this
API service, plug it into my applications that are actually using so that way
there's no downtime and then I can deactivate my old one. That way I'm not
causing downtime for the user I guess. That was the last thing I wanted to add.
I think we covered anything. Is there anything else you want to talk about
before we do the out trivia?

**Robert**: No, actually I feel we've had a pretty good talk here just kind of
covering all the high level points. Yeah if you're going do it, do it safely.

**Randall**: All right cool, so thanks again for being here. Also if you want us
to tell people your Twitter or email or whatever you want to share out there so
people can get a hold of you if they want to hit you up for more info, how...
what's the best way for people to contact you?

**Robert**: Yeah. @robertjd is kind of like my avatar all the things, so if you
are good Google robertjd and you'll find me. I don't use Twitter whole term, but
I'm on Stack Overflow a lot, on GitHub a lot. Yeah so hit me up.

**Randall**: All right cool and as usual I am @rdegges on all the things that's
R D E G G E S and huge thanks again to Stormpath who's graciously sponsored all
of the episodes so far. It's just an awesome company. You guys should for sure
go check them out. If you want tom thank them I recommend sending them a tweet
@gostormpath on Twitter and that's it for today. We'll see you guys next time.
Please stay tuned for advertising message. Thanks.
