---
date: 2015-10-26T17:16:36-07:00
title: 0x00 - WTF is OAuth
image: /static/images/casts/jackie-chan-wtf.png
cast: http://traffic.libsyn.com/thestormcast/stormcast-episode-0x00-wtf-is-oauth.mp3
summary: >
  OAuth is a funky protocol. Seriously. Who even likes it? In this episode we'll
  discuss what, exactly, is up with OAuth, and why the hell people keep talking
  about it.
---


**Randall**: What's up welcome to the very first episode of Stormcast, I'm your
host Randall Degges. Today we have our two first ever guest on the show. We have
Les Hazelwood the Stormpath CTO. Say hi Les.

**Les**: What's up guys?

**Randall**: Also we have Tom Abbott, the head of product here at Stormpath;
awesome dude. Tom say what's up.

**Tom**: Good afternoon.

**Randall**: Today we're going to be talking about some web security stuff. For
those of you, since this the first episode, basically what we're trying to do
here is talk a little bit about web security and have some fun. We're going to
be bringing people interviewing them about various security related topics,
talking about different protocols and best practices. Just in general things
that we think are fun as developers and things that hopefully you will too.
Also quick shout out to Stormpath they're an API service that stores user
accounts and does authentication and authorization. They're sponsoring this
episode completely so huge thanks to them. If you want to check out their
service it's stormpath.com. With that said this topic is OAuth. We're going to
cover and we're basically just going to get into what OAuth is, why you should
use it and how it works.  Both Tom and Les are experts in this area. I'm sort of
going to ask them some questions and we'll just have fun with it. First off,
first question for Les what's an OAuth? Give me some high level info here.

**Les**: OAuth is a way for… to authorize users web applications when three
parties are involved at least that's what is was designed for. There is a web
application that needs access to a user's data on a separate web application and
those three parties are the user, the first web app and the second web app.
OAuth as a protocol was designed to coordinate those three parties together so
that a web app can see the user's information if the user approves it.

**Randall**: Basically if I'm like a user and I'm on a website and I want to
login with Google login for instance that's more or less what you're talking
about, right.

**Les**: Yes so if I'm building a web app that wants us to get access to your
information I have to coordinate with Google but you have to approve it first.
Those are the three parties: me, Google and you.

**Randall**: I noticed that you said it's an authorization protocol. If I'm
logging in actually let's talk about authentication and authorization real quick
because those terms sort of terms sort of get thrown around all the time. Tom
why don't you tell us authentication and authorization.

**Tom**: Yeah, authentication is all about identifying who the user is. That's a
concern that's really orthogonal to authorization or sometimes let's call OXI
which is once the user has authenticated, what are they allowed to do and not to
do within your application? I could be authenticated into an application as
    tom@stormpath.com but I'd only be authorized to take actions or is it to
    view particular resources. Usually when you think of authorization there's
    really two flavors that are important in today's application. One is
    Role-based authorization and the other one is Resource-based authorization.

**Randall**:  Okay cool, so just to simplify things here, but basically when I
think of the OAuth the first think that really comes to mind is social login,
because that's what most people tend to know it from right. If I add a Google
login button to my website and someone signs in, is that Google login handling
both the authentication and authorization of the user since it's requesting the
user's permissions and login them in with their Google account or not?

**Tom**: It's both.

**Randall**: Okay cool so OAuth can handle authentication and authorization. We
got that cleared up.

**Tom**:  Cool.

**Les**: More specifically when I ask Google for your information, Google also
often authenticate first so it knows who you are so that when I try to get that
info, you can approve.

**Randall**: Yeah so basically what you're saying is let's say I'm locked into
incognito browser in Chrome. I'm not locked into any services. I click on Google
login button by my site I redirect to google.com and they say, "Hi Randall,
you're not logged in login first." Once I log in that's Google authenticating me
and then when I get prompted and say this website wants access to these pieces
of the data, do you approve yes or no. That's the authorization part, right.

**Les**:  That's what OAuth was designed for. Is you approving me access to
your, say email address, your first name and your last name. The fact that you
authenticated or had to login first is a side effect of what OAuth was designed
for. OAuth I just want to be clear is not an authentication protocol, but it's
    an authorization protocol about who can see what. Because people tend to log
    in so often in that process, a lot of people start to feel like it's a log
    in protocol.

**Randall**: Okay very cool I think that's an important think to distinguish too
because I get a lot of questions about that. Alright cool so let's talk about I
guess why this is needed in the first place. Let's talk about the website use
case. Now OAuth can do obviously a lot more than just web authentication. It can
also authorize like API request and all sorts of other things. Let's talk about
websites for the first part here. Back in the day if you're building a website
basically you create an HTML form on a page; log in page for instance you have
two input fields like maybe email and password.  Once the user fills out that
information, they post that data to your web server. You grab their credentials
you validate and you say you are logged in. Why can't I just grab someone's you
know Google log in information and post it on the Google on their behalf?
What's… why is OAuth needed? Why can I just do normal form-based authentication?

**Les**: Well you could do that; you could take the user's credentials and log
into Google on their behalf. The reason why OAuth was created is because most
people especially if you're in the security industry, you feel that that's
really bad practice because that requires the customer, the end user of Google
to give you their password and that's very, very risky.  Once you have
somebody's password, you can impersonate them. You can reset their password, you
can reset their account, you can change their credit card information whatever.
It's really, really risk to get raw direct access to somebody's password. OAuth
was created as a way to get the users information, email, first name, last name
without requiring your password. That's the whole reason why that flow was
invented between third parties and so that a web application talking to Google
for example or Facebook can get the user's information without needing their own
    password.

**Randall**: Yeah for sure. I'm glad we covered that because I work as Stormpath
here too and we get question about these stuff all the time and that's one of
the things we run into.  Okay so next question is for you Tom. This comes up a
lot as well, but if you're using OAuth to authorize users to log in to your web
application let's say, do you still need to use SSL on your website? Because
Google is handling your log in process for you or wherever OAuth provider you're
talking to do you still need SSL? Do you have to pay for that SSL certificate?

**Tom**: To answer that yes, particularly for an OAuth 2.0. I'm sure we're going
to get into this a little bit more detail, but I can just answer this very
quickly. One of the main differences between OAuth 1.0a and OAuth 2.0 is the
idea of having a sign every single request and cryptographic signature is
important when you need them to validate that the information isn't being
tempered with. The main reason why there's no cryptographic signature needed for
OAuth 2.0 is that they're delegating that fact down to network layer which SSL.

**Randall**: Okay for those of you out there that don't know so OAuth, what most
people typically refer as OAuth is just sort of generic protocol but there's
actually two variations of it that are commonly used. There is OAuth 1.0a, which
is still in use by some big companies Twitter for instance and then OAuth 2
which is what people sort of most commonly mean when they refer to OAuth.
Actually elaborate a little more on that. What's the difference between OAuth
1.0a and OAuth 2; just high level so that people sort of understand?

**Les**: OAuth 1.0a was all about signing a request and signing information that
was important to request so you could go ahead and say that this request is
being done on this user's behalf. OAuth 2.0 is a little bit different. It's more
designed for what would be considered a three legged interaction. Even if there
is a few little grant types that too support two support two legged OAuth. I'm
sure I'll talk about this a little bit later.

**Randall**: All right cool thanks. I think that definitely helps a little bit.
Let's change gears slight more, I think we should talk about API authentication
a little bit. If you're building an API service something similar to
*indiscernible* or wherever. Let's say you're building an API where you want to
send SMS messages through an API. Let's say API.  There's obviously different
ways to secure an API, the two that pop to mind for most people are HTTP basic
authentication which is what I really love personally. Then there is OAuth 2
which I personally hate. Since the show is all that OAuth, Les why don't you
elaborate a little bit. Give me your thoughts here. What do you like about basic
OAuth? Actually just go ahead just describe basic OAuth real quick. Les take it
from there.

**Les**: Basic authentication for HTTP is when you provide a raw username and
the user’s raw password, you catenae them with colon character and then you
Base64 URL code that value. You take the upper to that, you stick it in the
authorization header and HTTP request. That means when the HTTP request goes
into a web server you can look at the authorization header and reverse that
process and get the raw username and password and then compare that with
whatever you have the raw username and password stored in your local database to
see if there's a match then that request is authenticated and you can trust the
identity.

**Randall**: Basically it' the same thing as submitting like form-based logins
on the website essentially right. You get the user to supply the username and
password to you in more less plain text you check against what you have on the
database and you say yes this is the real or not it's not right.

**Les**: Yes, that's absolutely correct.

**Randall**: Okay cool. Why is that bad? Why do people need OAuth to
authenticate API services? Why can't they just use the basic OAuth?

**Les**: Basic authentication because the raw username and the password or more
specifically the raw password, is visible in a request even if you have the
Base64 decoded it's easy enough to see the value. If that request is ever
intercepted in any way whether you're at a coffee shop and the service isn't
protected that well and you've got people sniffing the network. Or maybe
somebody takes your request and logs it accidentally to the log in system.  That
means that Base64 value is now on your logs history storage or your search
engine for logs. It's very risky because there's many different windows where
that raw password could be exposed to potential attackers. Basic is very risky
from a password security perspective. If you're trying to keep your user's auto
secure there are many potential opportunities for that password to leak when
you're using basic authentication.

**Randall**: Just to go back a little bit here, when most API services the
support basic OAuth, I typically don't enter my username and password although
shout outs to *indiscernible* for making you do that which really sucks. If
you're listening guys you need to fix that. Basically most people who implement
basic app OAuth at an API service level will implement like API keys right.  I
guess here's a question. I'll give this one to you Tom. If I'm an developer and
I'm building an API service and I want to authenticate users securely, is there
anything wrong with using HTTP basic OAuth and generating API keys for my users?
That way they don't have to specify their actual username and password. Then
also obviously putting my services SSL that way all my traffic between my server
and the service are fully encrypted?

**Tom**: I mean I think it really matters. Different API services need different
types of security standards now. There was a very… is it right or wrong? Is
white or black? It's really a mix of things. The benefit of using an API Key
instead of username and password is that the API Key and secret can be tied to
directly to an account for accountability number one. Then individual API Keys
can be revoked, they can be enabled or disabled. They can be modified, recycled,
reused and there's a bunch of other benefits that an API Key gives you versus a
username and password.

**Randall**:  I mean just like Amazon web services right. Amazon web services
primarily works through basic OAuth. You sign up, you provision this access key
and they give you an ID and secret. Then you use that to make all of your API
request to Amazon web services right.

**Les**: They actually support both so believe it or not. They support the API
Key secret and they also support OAuth as a barrier token.

**Tom**: API Key in secret for Amazon they don't support basic OAuth. You have
to use Amazon signature algorithm and the request. You may be their key.

**Randall**: Elaborate on that a little more because I'm not so familiar with
this.

**Tom**: When you Amazon doesn't support basic authentication with the API Key,
ID and secret that's the username and password. They have their own cryptography
algorithms and digital signature algorithms that are used in the request as an
alternative to basic OAuth. Instead of basic it's another algorithm which is
probably a way out of scope for this cast, but we can talk about the
differences.  One of the other big interesting points about API Keys is that if
you use username and the password, and then you set up a piece of software that
needs to use those values to communicate with the third party service, if that
person never changes their password, now all their integrations break. API Keys
are really good they couple communication between machines and human beings
because you don't want to change one and have it break all your software.

**Randall**: I've actually heard that happen to quite a few services right.
Where I'm sure a lot of you listening to this can relate. You'll sign up for
some API service and when you join you give them the username and password and
then you look at the API docs they're like okay run this core command on the
terminal copy pasting your username and your password. I'm like, “What the fuck.
What's going on here basically?” Here's my misunderstanding, when we're talking
about API authentication with OAuth.  One of the main benefits is that you're
only going to send your username and password over the wire once and basically
what you're going to do is you're going to send that to the server, you're going
to authenticate that data from the database just like you are the basic OAuth.
Then your server is going to generate and OAuth token and then from that point
on your server making all these API requests, instead of sending their username
and password will just send this token. Is that right?

**Les**: Yeah it's really good observation some of the things that important
here about API Key authentication with OAuth is… remember I said OAuth was
really designed first for three parties.

**Randall**: Yeah.

**Les**: My application, the end user and say Google or Facebook. They found
that in that flow of communication, once you had some token or some mechanism
represented who the user was, that was all that you need to communicate back and
forth with Google from my app to Google for example in this person flow. Then a
lot of API developers said well that's a really great use case. Once I get that
token I don't need the third person involved anymore. I can just communicate
directly to Google.  A lot of people said that's two party communication so now
let me try to do the same thing for my REST API, where traditionally OAuth even
though it was designed for three people or three parties, once the two party
flow kicks in you can start using it for other use cases. People started
layering this in for API authentication even though OAuth wasn't initially
designed for that. It works just as well because once you have that token after
authenticating you can communicate directly back and forth without needing the
user’s direct intervention.

**Randall**: Okay that makes perfect sense. Basically just to summarize what
you're saying, once you authenticate with whatever provider is your OAuth
provide and you get this token, you can then use it to make direct API request
against whatever service supports that assumption right.

**Les**: Yeah so the general flow if you're using OAuth three APIs is typically
the user submits the raw username and the password and then that immediately
returns to token and then say your JavaScript API can then use that token to
communicate with your server from that point on. It doesn't need the raw
password like basic authentication would.  You send the token instead of the
password. The huge benefit there is that you're limiting the window of the
amount of time that the raw password actually needs to be sent over the network.
It's that one request that very first time after that you get a secure token and
you can use from that point on.

**Randall**: Also just to be clear, even that first time when you send the
username and password over the wire to like Google to authenticate, that’s still
happening over the SSL. I mean it's not exactly vulnerable right. You're not
exactly publishing this out there to your Wi-Fi hotspot.

**Les**: Well, again as Tom said, it depends on your security model. The really
important thing is TLS is a network level transport layer so while the data
center over the internet is probably going to be secure but anything that's on
the machine before and after the network transmission could theoretically see
that value so typically certain industries like banking and healthcare don't use
basic because even the network may be secure other things in reverse proxies or
internet routers or whatever might not be as secure so they wouldn't use basic
authentication in that case for example.

**Randall**: Okay so question for you Tom. For people out there who aren't
familiar to OAuth, in what circumstances which to you want to add OAuth
authentication and authorization to your website or API service? Let's talk
about website first. If I'm building a simple software and service type website
and I'm doing something like chat service right, where company is signed up and
all their employees can chat with each other. Is this something like I should
use OAuth to secure it or can I just use form-base log in data? Explain your
answer a little bit.

**Tom**: I think my answer to that it's actually going to be yeas. I think
you've said there's a lot of benefits to using OAuth particularly when I, you
think about how your managing session and scopes associated with the token that
gets return through the… for OAuth..

**Randall**: Okay let me interrupt you real quick, you're saying sessions and
scopes and WTF man.

**[OFF MIC CONVERSATION]**

**Randall**: The OAuth protocol obviously a lot of you listening to this are
probably like what the hell is OAuth anyway? That's why you're listening to
this. The OAuth protocol is typically complex right.

**Tom**: Yeah it's very  complicated the specification carries or covers many,
many use cases where there's three parties or two parties whether or not there
were passwords send over or whether a token send over there's always variations
of how these machines communicate back and forth and what data needs to be.

**Randall**: Okay so I'm going to sort of leave this a little bit to help out
here. Now OAuth typically has like a few part like people talk about it all
right. There's grant types and those are essentially the different types of
OAuth that allow you to do different things, they're different user case for
OAuth, right?

**Les**: Yeah.

**Randall**: After that we've OAuth scopes those are sort of just like
permissions that you're requesting whenever you authenticate with an OAuth
provider. Is that right?

**Les**: Yes so grand types are about, I'm going to provide some information,
some credentials whether it's a password or a biometric token or anything
really. It's something that proves you are who you say you are. That's what a
grant types and there are different grant types supported OAuth. Once you
authenticate with the grant type you get back a token that represents what you
can do after you've authenticated.  That token usually contains something called
Scope or can at least it's optional but a can contains scope. When a scope says
for this token the token represents the user account that can do XYZ or rather
    the bearer the holder of the token can do XY and Z associated with the
    servers. Scopes are really basically a set of embedded permissions that give
    that token or that the user of the token the ability to do certain things.

**Randall**: Talking about scopes really quick, now the way scopes work
basically right is that if you're building an application using OAuth basically
you want to assign permission when a user logs in essentially right. Let's say
you're building this chat website, you might have different levels of user
accounts you might have administrators, you can add employees, remove employees,
shadow ban them if they're total jerks.  Then you might just have employee
account so you can log in and just post in chat rooms and so forth and so on
right. Tom if I'm building this application, this is the use case where scope
are useful. Is this, how would I define that? Is there a standard for defining
scopes or is it just all made up fake human stuff?

**Tom**: This is where the OAuth specs sort of fails a little bit, they don't go
into it too in-depth other than it's a space to eliminate set of strings. For
example the scopes that you would get from LinkedIn to expose your profile data
through the token will be totally different than the scope property that would
be exposed via Google to do the same exact thing. It's up to your application to
figure out how to read and understand scopes and they're really user defined.

**Randall**: Give me some of real world examples here. If I'm to find this chat
application specifically, what my scopes look like as a string? Just give me an
example.

**Tom**: Yeah so going back to your examples I'd say things like, you could say
things like admin or moderator or chatter or really whatever you would want to
do define the role for the user.

**Randall**: What if I'm… have multiple permissions, how will you represent
that?

**Tom**: As a spaced alimented string so it will like in the case of you know
there's really different ways you can think about scope. You can think about it
defining the roles for what that token is allowed to do. You can also define the
scopes in what the data are what the token is about to access.  For example if
we want to go for like real world may be outside of this fictional chat
application, if you want to take a look at LinkedIn. They have this way that
they do things where they define their scopes as either R or W which defines
Read or Write. For example the scope is in a LinkedIn token would say R_read
profile R_email address. That token with that scope would have the ability to
read bearer's profile data and then also read the email address.

**Randall**: Okay that makes perfect sense. Basically so scopes are just any
arbitrary things you define for application. They're you own sort of you roles
and permissions basically.. Now let's go back to grant types the OAuth 2 spark
there's four grant types right. There's implicit grant type, the authorization
code grant type, find credentials and passwords grant type.  Let's dive into
each of the use cases for each one of these and just sort of cover that, so that
people know exactly what they can do with the OAuth protocol because I feel like
this is one of the big areas that I was for sure confused about when I was going
to start with this stuff. Let's start with the web app stuff there's two of the
grant types; the implicit and the authorization code grant types. These two are
primarily used in the web applications, right Les?

**Les**: Yes mostly.

**Randall**: Let's talk about the implicit grant types first. Explain to me what
the used cases for this and then… actually let's pass this one to you Tom. Let's
talk about implicit. What's the user case for this? Why would I use it? Why
would I not use it?

**Tom**: Implicit is for third party access and the main reason you would use
that grant type is to be able to deliver access token to a third party without
having to understand the user's username and password. Really whether that grant
flow looks for like is what you'd end up doing is the user would click a button
and that button would be for example in the third party application that would
be like a log in with Google button.  What would happen is that the website
would either redirect or pop something up to allow the user to log in to Google,
whoever's holding the credentials. Once the user logs in with those credentials
and it is successful they may or may not have to give permissions for particular
data to be exposed to the bearer token and then what would end up happening is
then Google would redirect back to the application with the access token.

**Randall**: Basically what you're saying is wherever you go to a website and it
has a Google log in button, I click it. It redirect me to Google and says
Randall do you accept this permission to spam you're Facebook wall whatever and
I'm like yes. Then it redirects me back to the site and I'm magically logged in
and the site I was on now has the access token that Google gave it. That way it
can API requests to Google for my all my personal information to spam on my
friends right.

**Tom**: Exactly.

**Randall**: Okay cool just want to clarify. Now here's something that's a
little confusing to me, well not confusing, but it's a little weird. We had this
implicit flow which is basically generates the token for the website. Now the
other website flow is the authorization code grant type. Now this does
essentially the exactly same thing except instead of returning access token you
return this authorization code thing instead. Why don't you tell me why the hell
they decide to do this and what purpose is?

**Tom**: It's really the implicit flow with added level security. The
authorization code and most implementation is this there's one time use token to
exchange this code for an access token which is usually done through server to
server communication meaning that it's less exposure for the access token over
the wire. Because if you think about all these redirections that are happening
when you take a user that's on one site, having them send them to another site
and then send them back to that site.  There's a lot of area that the user in
this access token is being send through whereas if you're only sending this one
time use token back to the server and the server communicates that the code
directly to whoever is going to be giving back the access token that's the
server to serve communication onetime user; it's just added level of security.

**Randall**: I mean why would you ever use the implicit flow then? It seems like
if there's more security authorization code then you can make the exact same
    thing happen. Why even bother? That seems sort of a fail to me?

**Tom**: It's mostly like again security is one of those things, you can either
be as secure as possible or you can do the simpler solution. There's an added
level complexity when you use the authorization code and some of other things
that you need worry about like how do I generate this onetime use token, how do
I secure this one time use token, what are sort of state that I need to worry
about that can be the cross site or cross forgery can happen associated with it,
whatever that would end up happening so.

**Randall**: Basically security versus ease of use is what you're saying right.

**Tom**: Exactly.

**Les**: This is Les, as Tom kind of hinted that there's many different users of
security like a banking application probably never use implicit grant flow right
but may be social network around indoor games might because they're not exposing
credit cards for… you know what I mean?. It depend on your use cases to which
flow you use.

**Randall**: Okay so basically I'm going to summarize what we talked about here.
If you're a developer building a website and you want to enable other third
party sites to access your user data, basically if your site is dealing with
very confidential private information you should implement the authorization
code grant type right. Otherwise if you're doing something may be that doesn't
require such a high level security, you should just use the implicit grant type
and save yourself a little bit of headache. Is that pretty accurate summary?

**Les**: It's pretty accurate, but the key part of authorization code flows in
this case is that there is always three parties right, there's somebody
requesting information, there's an application that has it store and then
there's the end user who has to grant permission for that third… for that
application to get access to their data. If you need authorization from the end
user the authorization code grant flow is built specifically for that purpose.

**Randall**: Okay cool and I think that makes perfect sense. We covered that now
let's go to the other two grant types that OAuth 2 supports. These two are aimed
specifically for authenticating API request for the most part. There is the
password grant type and then there's the client credentials. Let's start with
password because that's sort of really popular today with angular jazz, react
jazz, amber and all these different things. Let me fire this question off to you
Les. Explain in high level terms if you can, the password grant type just
overall what it does, how it works and what the use case is.

**Les**: The password grant type is kind of authorization or basic
authentication essentially but it's done in an OAuth specifically way. When you
make an OAuth request you're supposed to have certain data in the request body,
and the server knows to look at that body in a certain way. Really the access or
the password grant type is this traditional raw username, raw password based
authentication using the OAuth protocol flow.  When you authenticate with the
username and password, you get back an access token that allows say your
JavaScript app or your mobile application to make continue as calls back to the
server. Password grant flow again was all about let me send those passwords over
the wire once and then I'll get the token that allows me continued access after
that point so I don't have keep exposing my password.

**Randall**: Basically as an user you just send your username, password up to
the server, you get a token back and you just use that token to authenticate all
your future request right?

**Les**: Exactly.

**Randall**: Another question, obviously this is something that people talk
about for angular and reactor and all that stud. Explain a little bit about why
that is. For instance, is this something you'd ever do for maybe you're at a
*indiscernible* job and you need to access API data OAuth. Is password grant
something you'd ever want to use for that or is it only really useful for client
facing stuff like web browser with angular or reactor something like that?

**Les**: The password grant flow was really based on people logging into
applications not for machine to machine communication. If you need to write a
grant job that communicates with a third party REST API then password grant type
probably wouldn't really be used for that because there's no user involved in
that scenario.

**Randall**: Basically it's really only useful for people building like
JavaScript APIs. You have some API that's powering your front end website which
is users and angular stuff or whatever right. You're saying that's the main use
case for the password grant type?

**Les**: Yeah well that's the main use case if the user is supposed to submit
the raw password directly to you.

**Randall**: Right so basically if I'm using Google log in I would not ever do
the password grant type right because I'm not the one who wants to receive the
users' Google log in.

**Les**: But if you store the user accounts and their passwords directly in your
application, then you will absolutely use the password grant type.

**Randall**: Also this is an important distinction right. The two grant types
you talked about before, implicit and authorization code these are all based
around these three-legged workflow. Where you have one site who owns the data
user like Google then you have another side who's just trying to accept the log
in through Google. For instances may be whatever.com or something.com.  Then
finally you have to user and the user is on something.com and they want to log
in with the Google account. However with the password stuff, what you're saying
is Google is not involved at all, it's just this website that owns the user
directly right.

**Les**: Yeah that's totally correct.

**Randall**: Okay cool I just want to clarify that because I know it comes up a
lot. That's a password grant. Now Tom let's talk about client  credentials
grant. We covered basically all these different browser used cases. I'm assuming
client credentials is sort of the only real thing to use if you want to script
the grant job or for instance and you want to get pragmatic access to data using
OAuth protocol is that right?

**Tom**: That's correct so you guys were definitely hinting on this earlier, but
client credentials is used for machine to machine communication. The client
credentials grant type is all about exchanging for example and API Key could be
an ID or secret or ID and secret and getting back and access token.

**Randall**: Okay so essentially it's a lot like basic authorization. The
developer has some API Keys, they submit it to your server so not like Google
it's another two-legged workflow. You have this username and password stored in
your database somewhere. The user making the request submits it to you with the
API Keys and then you send back the token right?

**Tom**: Exactly.

**Randall**: Then they'll just use that token to authenticate all their future
requests.

**Tom**: Exactly.

**Randall**: Okay cool now in that case specifically why not use basic OAuth or
does it really matter?

**Randall**: There's some other things that you can add to the token to allow
very elegant and secure solutions. For example access tokens can expire and
access token also mean that if it is compromised and it does expire that it's
only exploitable for a finite period of time, whereas if it's an API Key in
secret, if it's able if it's cracked for some reason if they are able to get it
on over the wire then, they have the keys to the castle.

**Randall**: Now I know both of you knew this was coming but we've been talking
a lot about token but we've not talked about what's up with token right. Because
tokens are the most generic big ass word in the world pretty much. When I think
of tokens I think like Jacky cheese; you know basketball token right. The
reality is that all tokens are really it's just a string, that's right, isn't?

**Les**: Yeah in the world of identity and specifically OAuth a token is usually
a piece of string and how about token is formulated or what's inside the string
specifically in OAuth use case, is completely up to the server implementation.

**Randall**: You're saying OAuth talks all of these stuff about tokens about
doing this in security whatever I mean doesn't say jack shit about what a token
actually is just confirming that.

**Les**: Yeah that's actually true.

**Randall**: Dude these guys, these guys.

**Les**: Yeah there's no, how the tokens are exchanged is what's really OAuth
and the security model behind that. What the token is, is not covered it all on
this specification.

**Randall**: As you're listening to this, you're probably now being able to
understand why OAuth is so confusing and there are so many articles and content
out there about to make it less confusing. Anyway so yeah so tokens since we're
on the subject let's dive to a little bit too. Now most tokens nowadays are
built using this other standard called JSON Web Token standard right. So let's
talk a little bit about that. Tom tell me a JSON Web Token is?

**Tom**: It's just a normal string.

**Randall**: Just explain a little bit like high level, what the purpose of this
is and why not use a randomly generated string as an access token?

**Tom**: A JWT or sometimes called a jot is really what it is, is it's a set of
information that's cryptographically signed with a shared secret. The main
reason why you would use a jot instead of some randomly generated string all
comes down to the amount of state that your API or your application would need
to store. If you're generating just a random string then you're going to have to
tie that back to the account that was given the token. What that means is that
you're incurring state in your application on API.

**Randall**: Basically what you are saying is just like a normal HTTP sessions
right, if I log in with the browser you sign in some random session ID.

**Tom**: Yeah.

**Randall**: I store that in my database on my web service somewhere. Every time
you make a page request back to my website, what my web service going to do is
take that session ID look it up in some cache or whatever and then spurt your
account information and say okay this user who just made a page request
definitely Tom. Are you saying this is essentially the exact same thing with
tokens?

**Tom**: No, so tokens… why the JWT is important is because it actually it
allows you to become stateless. Meaning that you don't have to store anything in
your database to tie this jot back to the user. It itself as the token, it is
stateless for your application to have to actually consume when it comes back
in. Now what the jot is at the end of the day, is it's a period or a dot
delimited string and it comes in three sessions. You have a header, a payload
and a signature.  The header is Base64 encoded JSON that includes information
about some nitty-gritty details around particularly maybe what type of jot this
is and also what algorithm they used to sign. The payload can be all sorts of
the next piece of the JWT or the jot is the payload. The what the payload is
that's a bunch of claims about what the user is. This can be up to your
application that generated the token to put whatever information it would need.
Sometimes it's something as simple as just the subject field with just stating
who the owner of the token is. Sometimes it can extremely complex such as it
will have things like exploration time, issue that time. It could have
additional claims about anything about the user and the state in which they
authenticated in. It can also include a claim about the scopes that this user
gets by owning the token.

**Randall**: Basically what you're saying is if you're using this like a jot
essentially as your token, the user can use something like open source library
or whatever to basically to take the jot string; that period delimited string
and basically transform it into useable JSON data that they can then inspect,
right? As a developer when I create this token I can embed whatever JSON data I
want in there. I can say here's this user account name or here's this user's
permissions or scopes. Here's this user's favorite dog color or something. Then
I could also include like an expiration time of the token too. Maybe this token
expires in like a year so after that I re-login, that's what you're saying
right?

**Tom**: Exactly.

**Randall**: Okay cool so one other things just going back and I'm going to fire
this question off to you Les. Tom was explaining the three different fields in
the jot right. The first field is header which has Meta data about the jot. I
know because Tom said this that one of the field that are exclusively states
what algorithm and signature was used to generate this token right.  There have
been some security issues around this. There have been some flaws in different
libraries and stuff where these was actually a huge problem. Could you just talk
a little bit about that and sort of explain is this secure yes or no?

**Les**: Yeah it's secure if you use the algorithms the correct way. One of the
things about securing in cryptography specifically is that it's not good enough
just to know the algorithms, you have to know how to use the algorithm and how
to manage keys associated with the algorithm. Just to kind of back up a little
bit before we used to have session IDs and cookies, now we've these JWTs inside
of… or packaged up in various different ways It's really important to make sure
that when you create this package JWT with information in it, to make sure that
nobody outside of the application can temper with it, can manipulate. You don't
want that JWT to represent Joe today and then somebody changes it to mean Sally.
That will be a really bad thing for your application because that could
impersonate identity. You don't want that.  The way around that is you sign the
JWT string with a digital signature, with a key that's known only to your
application. Then make sure that anybody outside of the application can't change
the value without you discovering that they've changed it right. Digital
signature is all about what they call message authenticity; making sure that
string stays exactly how you expect it to be without anybody touching it.

**Randall**: Basically what you're saying is like I'm a developer and I'm using
JWT library maybe I'm using the one you wrote because you build a JWT library
right?

**Les**: Yeah, yes called JJWT for the JVM for Android and Java.

**Randall**: That's the best JWT library out there for Java isn't it?

**Les**: I think so. I'm biased of course, but I think it has the most stars on
GitHub so that's may be a good indicator of its popularity. I don't know.

**Randall**: He's humble bragging but it is the best JWT library out there so
definitely  go check it out. It's JJWT right?

**Les**: Yeah that's it.

**Randall**: Anyway so basically if I'm using this library or any of the other
libraries right the idea is that I get some JWT and one of the things I can do
is verify that it hasn't been tampered with right.

**Les**: Yeah so typically libraries especially JJWT will automatically validate
a token when you receive it and you parse it to find out the information inside
of it so. When you parse it, you're supposed to specify a signature, a digital
signature key and the JJ… the parser will typically on whatever library you're
using will look at that key and try to use it to confirm that the payload hasn't
been manipulated. Depending on what key algorithm you're using where it's RSA or
a share key HMAC, there's all these various algorithms, it goes about in
different ways making sure that nobody's changed that key.

**Randall**: Okay cool so basically with JWT is I am guaranteed as a developer
that wherever I created this token, whenever I receive it back it's still the
exact same way it was when I created it right.

**Les**: Absolutely that's all about digital signatures. I want to be clear JWT
also supports something call JSON Web Token Encryption which is about
obfuscating the data so no one can see it. Digital signatures are all about
making sure no one has changed. It's separate concerns so, whatever you put into
a JWT, most people don't encrypt they just rely on SSL. For most people whatever
data they put at JWT they need to be really careful to make sure it's not super
sensitive data because mostly usually are not encrypted.

**Randall**: If I'm basically building a stock trading algorithm or a HIPAA
compliant app or something and I'm allowing patients to look at their X-ray
images or something really private it's probably a good idea to look into JSON
Web Token Encryption in addition to just the normal signature stuff right.

**Les**: Exactly yeah so that's a pretty rare case where you would actually
store such sensitive data in the JWT. The vast majority of web application I've
personally come across don't actually need that, they just need some user
identifier or something that can be publicly made plus information scope, and
that's usually not good enough. Most JWTs in the world are just signed, they're
not necessarily encrypted but you can add that in for an extra layer of
security.

**Randall**: Okay very cool and also I know this briefly before Tom, but one of
the main benefits JWT is and one of the reasons why they're so widely used
particular with OAuth where you have to have some sort of token in order to make
things work, is that because they're *indiscernible* and because you can verify
that the token hasn't been tampered with, you can avoid the database query on
every single page request essentially right?

**Tom**: Exactly.

**Randall**: I mean that can make a huge performance difference to applications.
Just elaborate a little bit on that.

**Tom**: Yeah definitely, I mean if you think about any sort of API at scale or
any application at scale, the more stuff you have store in memory or things that
you have to look up in a database, it not only affects time and time is
everything for APIs but it also makes sure that you're spending more time
processing their request versus trying to figure out who's calling the API
because all of the data stored in a token.

**Randall**: Very cool yeah I know so I know that performance benefit is huge
especially for us here even I know it uses a lot internally a lot to get a lot
of performance benefits. Okay next thing I want to talk about is I mean we
covered all the four grant types, we covered implicit which is for browser
authorization code, which is for browser, the password grant flow which is sort
of the browser based APIs.  Client credentials which is 100% for server to
server communications. We covered basic OAuth. The last thing we sort of need to
cover I think is access and refresh tokens because these words get thrown out a
lot. We talked about tokens but there's… in reality there's basically two types
of tokens. These are not part of the OAuth spec right?

**Tom**: They are actually.

**Randall**: I thought they were their own spec or am I mistaken.

**Tom**: No there in the OAuth 2, OAuth C.

**Randall**: I'm learning stuff new today, pretty cool.

**Tom**: Earlier when we were talking about the four different grant types I was
like well there's four grant types, but there's really a fifth. It's not about
generating an access token it's about refreshing and access token. That's really
where you hop into the discussion around what's an access token and what is a
refresh token and how do those two different types of tokens interact with each
other and how does it affect the user experience.

**Randall**: Okay so let's get into this so Les just high level what's the
difference between refresh token and an access token? Let's say I'm logging in
using password grant from my angular app, right. What specifically I'm I giving
back in the response body, access token or refresh token one or the other, both
like does it work?

**Les**: You'll always get an access token back because that's the thing that
actually that allows access to data. That's the thing that gives you the ability
to even access the data or even an API for example.

**Randall**: Well unless you're using the authorization code grant type right?

**Les**: No I'm say when you use that you'll get back an access token.

**Randall**: Okay after using authorization code.

**Les**: Regardless of the grant type what you get back is what we're talking
about now. You always get access token back because that's the thing that gives
you access. Refresh tokens may or may not be there depending on the service if
they implement they support refresh tokens. What a refresh token is for, is
allowing the holder of the access token to get more access tokens if they need
to continuously access the servers overtime.  The interesting thing about the
access tokens is you can restrict them to a very small window, and maybe they
should only leave for five minutes, 10 minutes, half an hour. Maybe the access
tokens should live for three days, fives day a month depending on your use case.
You can expire those access token quickly but use the refresh token to get more
access tokens.  This sound kind of confusing but what you're doing there you're
limiting the window of how often that access token is sent over the wire and how
might be exposed to third parties incase parties ever see that token.

**Randall**: Basically the idea with this what you're saying is because you're
using the access token to authenticate every request and you're probably making
a bunch of page request in a browser or may be if you're doing client
credentials grant type, you're making millions of server site API request
potentially right? You're sending this access token out constantly and what
you're saying is that with the Refresh token, it basically means you can
basically switch up your access token every so often.

**Les**: Yeah that's true and here's a really another really good use case of
why this is valuable. Let's say because tokens can be state full and allow your
systems to be stateless. You can put permission in such in the access token.
Let's say that while that access token is valid for 10 minutes, half an hour,
the underlying permissions for the user changed may be you can't see a
particular piece of data anymore. When that access token expires, the refresh
token is used to get a new access token and the new access token will have the
new set of permission.  It limits the window of how often the token id expired
as well as the permissions and the functionality associated with that token.
Services and end users can either revoke them or change their scope really to
limit whether service, a client can do when they're calling the service. It
gives a lot more control over how often or how valid those tokens are.

**Randall**: What is some good defaults to set here? I mean let's just say for
example I'm building a site whose security requirements are pretty lurked like
I'm just going to some software or service project, maybe it for a client, maybe
it's for fun; whatever. I'm not holding any in particularly sensitive
information. How long should I set the duration for my access tokens to be in?
How long should I set the duration for my refresh tokens to be in?

**Les**: It's a good question. It's totally dependent upon how often you want
your end user be forced to log in. If you only want them to… if you want them to
log in once and then only have to log in again for another 30 days you have two
scenarios if you're using access tokens only you just make that access token
valid for 30 days. If you're using access tokens and refresh tokens, you can
basically say the access token is maybe only valid for 30 minutes, but the
refresh token is valid for 30 days.  The take away is that whatever the largest
of the two tokens that's the amount of time that the user can use your service
without being forced to log in again. As an example of Facebook I think their
refresh token is valid for 180 days, basically six months. You might only be
forced to log in once every six months.

**Randall**: Okay now what if on the other hand I'm building something like a
banking website? What are some just general best practices there? What would be
an acceptable access token time out and refresh token time out? What are some
good defaults?

**Tom**: Again it depends on the service and the network layer involved and
whether token encryption is used or not but let's assume token encryption is
used then, you might want to limit your access tokens to be alive for no more
than anywhere from three to five to 10 minutes at most. Then may be a refresh
token valid for an hour or two so that the servers requires you to log in after
using the service for an hour.

**Randall**: Let's say I have a situation where I've a refresh token whose
expiration is one hour right. I just log in and I get this brand new refresh
token that expires in an hour and my access token expires after 15 minutes
right. Does this mean the maximum possible duration of me being logged in is 1
hour 15 minutes because at the very end of my refresh tokens time out I could
request a new access token. Could I request the past, the expiration of refresh
token or what typically not let you not do that?

**Les**: Now it depends on the server. If you use a refresh token to acquire new
access token the service can give you a brand new access token and a new refresh
token if that's going to extend the life of your session.

**Randall**: You can actually request new refresh tokens as well.

**Les**: Well when you access, when you request an access token the service
might give you back a new one refresh token if the service is saying it's okay
to extend the life of the session.

**Randall**: Okay Tom, I see you are busting at *indiscernible*.

**Tom**: Yeah so like OAuth 2 spec doesn't really set any sort of guidelines
associated with this and this is why this is one of the reasons why it's sort of
a little bit more annoying in complex than just like and cut and dry answer.

**Randall**: Thanks so I feel like we've covered this pretty well. I want to
throw in a last section here honestly just myself about why you guys think OAuth
sucks and what you think we should do deal with this us developers. Because
obviously this shit is confusing. There's a lot of stuff you have to know to do
well. I mean we talked about the high level stuff here, but the reality is we
could go into all the specific minute details of these all day long.  I mean we
will in future episodes. We're trying to keep this a little bit more beginner
friendly here, but Les why don't you start on and tell me what's your opinion of
this? Do you feel like this is sort of a good thing in the OAuth community? Is
this is a good security protocol? If not just elaborate give us some ideas. What
are some things you think we could improve or are there other protocols you
think have promise for moving people too in the future?

**Les**: Yes so I think in general it's a good thing. The creation of a standard
the fact you can do three party interactions more securely than we used be able
to I think these are all good things. The things that suck about OAuth
especially may be OAuth 2 is that without getting any details maybe it's worth
another podcast, but OAuth 2 does not require digital signatures for the entire
request. The request might be manipulated even though the token may not be
manipulated.  OAuth 1.0a, the older version did kind of make those guarantees to
a degree and so some people might perceive OAuth 1.0a is more secure that OAuth
2 again with security use cases determine relevance. There's some difficulty
there I'd like to… and OAuth 2 actually has in the spec, committee now the a
digital signature mechanism for OAuth 2. It's not approved but it's waiting in
RFC channels to go through an approval process. There's some enhancement there
but all of these things signatures, how the permutations of what grant types do
you use and access token, all these other stuff is really confusing to people if
you aren't cryptographic experts or if you're not identity protocol expert.
OAuth sucks from complexity perspective, it handles all these use case,
different flows, different whether I'm talking about two people or three people
or tokens. This is all really a lot to chew on. It's a lot of information to
deal with if all you want to do is just build a web app, right. OAuth sucks from
that regard, but the foundations are good, if you need to support these
different protocols.

**Randall**: Alright cool and Tom I know you especially, probably countless hour
since I've known you digging through the OAuth specs. I know you've memorized
like most of the sections by heart which makes me think we should karaoke at
some time. I mean give me your thoughts man. I know you have some pretty strong
opinions.

**Tom**: Yeah so Les was hinting at this earlier like OAuth 1.0a is considered
more secure because the signature that you can put on the request. The bad thing
about OAuth 1.0a is that that signature was complex enough for the average
person that they just were very resistant to using it and they remove it from
OAuth 2.0.  Then on top of that like if you take a look at OAuth 2.0 was
supposed to be is it was supposed to be the authorization framework for the
internet. Really when you take at how everything was changed and modified and
the spec process you really watched something die by a thousand cuts. What you
ended up is this like wishy-washy spec that didn't really make clear opinionated
decisions, what you have to do when you make a spec.  The interesting thing
about OAuth 2 is that it is in the state that it's in. It's still useable, but
then all of these different OAuth 2.0 providers are guys that are generating
tokens based on that protocol; all are doing different things. It's inoperable
so like access token that I get from Google and Facebook is like totally
different.  The end points there I end up using I've to dig through the
documentation it's not the same documentation. I just can't say, ''Okay Facebook
implements OAuth 2.0. They're going to have a slash OAuth slash token end
point.'' Where things are starting to get a little bit prettier is in a standard
that's built on top of OAuth 2.0 which is called OpenID Connect. In that spec,
that's where you actually see opinions being made about what the end point
should look like and also what the token format should look like.  That's really
I think where people are going to be going in the future which is, "Okay OAuth
2.0 was nice and it does provide a lot of value when it comes to generating
tokens for my applications, but when I need to do some really third party or
three party interactions it's really going to be OpenID Connect."

**Randall**: You're basically saying in the future you're sort of polling for
Open ID Connect is what, if that just summarizes.

**Tom**: Yeah everything that was wrong with OAuth 2.0 is attempting be fixed
with OpenID Connect.

**Randall**: Well thanks both you guys I think this went really well for a first
ever show. It's been awesome having you guys on. Before we go I'll just let
people know where they can find you. You guys want to pluck your Twitter or
anything like that incase people want to shadow you with questions anything like
that? We'll do Les first.

**Les**: Yeah I mean most people with around the identity work that I do with
Stormpath and protocols, you could just contact stormpath.com or
support@stormpath.com to get in touch with me. My Twitter is @lhazlewood, that's
L-H-A-Z-L-E-W-O-O-D.

**Randall**: Awesome and Tom.

**Tom**: Best way to contact me is Twitter I'm @omgitstom.

**Randall**: I love your name. I'm Randall and my Twitter handle is and lastly
be sure to check out Stormpath they're @gostormpath on Twitter. That's it for
the first show. Thank you guys so much for listening be sure to tweet with us
and send us email and stuff whether you like it or hate it, we want to know.
We're going to make this think amazing in the future and we want your feedback
to help and that's it. Also we're about to get a Stormpath advertising going
there, so please stay tuned for that. Thank you so much peace.
