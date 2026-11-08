# EUPL is great

Once upon a time, the internets used to have a phrase "IANAL" in blog posts such as these. Aside from being an Americanism (something about unauthorized practice of law), and of questionable usefulness (doubt this would fly in court; though then again, America!), it is also clearly lacking a ♡ (heart kaomoji).

Alas, copyright is dead, and so is software licensing. The most obvious issue is, of course, that Scam Altman can fool the entire copyright system by downloading all internet 100 times over and encoding this into matrices, and then claim that poking at them produces new works (even when it contains the same words, verbatim). But it's not the only one.

Quite frankly, software licensing has been struggling for quite a while. Do not be fooled by the paragraph above - copyright is working as designed. It's a legal tool to secure big capital, and big capital being given leeway to wiggle around the law is nothing new. Software licenses were a bit interesting - they are distribution of certain rights bestowed upon the user by the copyright holder. More interesting yet was "copyleft" - the idea that the rights would be viral and self-sustaining, and changing them would be extremely difficult without near-universal consent.

Still, "copyleft" is but a tool in class dynamics. It gives software author the pretense to go in court and sue, if license terms are violated. That is not sufficient - court is time-consuming, usually expensive, not particularly rewarding, can be relitigated until the author goes bankrupt, and dealing with a court of another country is quite hellish. History knows a lot of poor souls who have had stronger claims on exclusivity over their intellectual labor and haven't won the court struggles (even if they made it there) - seriously, go look up Disney or something, it's dire.

The real heroes here are the organizations, largely non-commercial donation-funded ones, that have taken up those court cases in authors' stead to enforce copyleft compliance. And those organizations' lawyers, because we& don't humanize organizations on this blog. Thank you for your efforts, sincerely.

Still, the entire "copyleft" thing is having a bit of a rough time ever since demand for chatbots skyrocketed. And as mentioned, licenses are only a single tool in class dynamics, one that is applied unevenly. This understandably made progressive people upset and disillusioned. Many swore off doing public work that is contributing to FOSS, many started publishing their projects (if any) unlicensed, or with funny licenses that make lawyers shake their heads in disappointment but send a pretty clear signal to potential users that they'll be fine.

And frankly? Yeah, we get it. We think the Github-style public commons are no longer viable, and that alternative means of organization are the way forward. Unlicensed and funny licenses make us somewhat *scared*. Not really because we expect to be sued, but just as an OCD thing. So we still prefer to license with EUPL.

So, this one is a weird blost. It is weird because we intended to write it... oh god, *3 years ago*. But what's done is done, and we have spent a large amount of time researching EUPL for purely autistic and OCD reasons, so might as well share our musings with the world. Sure beats another slop news entry, yeah?

## What's in a license

Let's establish a bit of a common ground. We're quite sceptical of the legal usefulness of software licenses. So, *why* a license at all? What does it *mean*?

For us, a license is... a commitment, and a virtue signal, in a good way. "Virtue signalling" was coined as a pejorative by people who have difficulty having morals against those who succeed in this; but by itself, it's perfectly normal. Establishing one's morals is important; and in a public space, it takes the form of speaking out publicly.

So for us, a license means that the author(s) are (vaguely) morally aligned with us. `LICENSE` is just a small little file in the repository that we check for this. Not the only one, of course; it is our habit to also check out "Code of Conduct" (wouldn't want to interact much with a project that values civilty and respect, but doesn't try to make community spaces safe for minorities) and "AI policy". It is not absolute; we know horrendous projects with "good" licenses and great and ethical projects that are effectively proprietary. But looking at the license, we can get a bit of an intuition behind the author(s) intents. Some authors put out detailed blog posts on licensing, how they approach funding, and what drives them to make software; all of those things might as well be much more important, and influence our judgement.

But well, in abstract, what makes a "good" license for us? Here are the qualities we are looking for: reciprocity, hostility to corporations, interoperability, accessibility. Each of them deserves their own little section.

### Reciprocity

We don't really make many things that blow up in popularity outside our circle of friends, so this point is a little moot. Still, what we're looking for in work in commons (which is what we perceive "FOSS" to be, really) is reciprocity. We are putting our time, effort and soul into something, usually for free. We want to get something in return: some headpats, being said "thanks", or even just the ability to work with somemany on shared good cause.

"Copyleft" as a concept slots in nicely here: the "shared good cause" is code that is useful for us and others, and we want it to keep being available and free to modify! This is pretty basic reciprocity.

Honestly, we think it's not really enough; availability of code has long been viewed as a basic right, and the promise of being able to contribute *maybe, eventually* was played up as end-all be-all. We want to grow enough as a creature to tip some of the creators of software we use with some money. Alas, we're not there yet. But we genuinely enjoy submitting bug reports and patches when we can, to be a little more involved with the developer(s) and build a little social connection; so we like to think we do a bit of our part, here.

And yeah, we genuinely enjoy working together. So when our code is open - we quite welcome interaction. Just, yes, the expectation is that we *will* be interacted with, if there are improvements to be made.

### Hostility to corporations

There's only so much one can do here, when all software can be license laundered with a slop machine. But prior to that, [Google banned EUPL from internal usage](https://opensource.google/documentation/reference/thirdparty/licenses#european_union_public_licence_eupl_not_allowed)! We'll take a win when we see one.

### Interoperability

In abstract, EUPL is similar to AGPLv3. But *wow*, AGPLv3 does *not* play nice.

Did you know that BSD4 clause (permissive open source) is [incompatible with GPL](https://opensource.stackexchange.com/questions/8040/why-does-the-clause-3-of-4-clause-bsd-makes-it-incompatible-with-gpl)? Or [OpenSSL license](https://www.gnu.org/licenses/license-list.en.html#OpenSSL)? GPL is viral and requires users to license also GPL; or have license *explicitly* provide compatibility clauses with GPL. And that's before even getting into the part where "dynamic linking" is fine but "static linking" is not. It's [weird and legally dubious](https://interoperable-europe.ec.europa.eu/collection/eupl/matrix-eupl-compatible-open-source-licences#section-3) and also hostile to languages like Rust, gee thanks there.

EUPL is pretty nice in this regard: you pay for what you use. Using a EUPL library does not require you to change your license. If the library is used unmodified, using a notice similar to MIT/Apache2 style (with links to upstream repository) is enough. Using modified library requires making the changes easily available, but it's usually easier to upstream the changes instead; that's where the reciprocity comes in!

EUPL also has a [list of compatible licenses](https://interoperable-europe.ec.europa.eu/sites/default/files/document/2014-02/General%20EUPL%20v1.1%20compatibility%20Matrix%20v08.pdf), both ways: pretty nice to avoid guessing if licensing is compatible or not.

### Accessibility

Honestly, this part is quite lacking. EUPL... tries. It's [translated to 23 languages](https://interoperable-europe.ec.europa.eu/collection/eupl/eupl-text-eupl-12), which is probably relevant for courts and lawyers who don't specialize in software. It's also made by EU, which means the text is generally more legible and understandable to a laycreature like us.

But let's face it: copyleft licenses are messy and difficult to understand. MIT/Apache2 are a lot easier to grasp, even conceptually. To an extent, this can be helped with educational articles and blosts (oh hey there, fourth wall!), but there's only so much to be done here. Licenses are but a tool, anyway.

### Bonus entry: pissing in FSF's cup

FSF is not your friend. The "four freedoms" it pursues are of questionable utility, and it's [led by a creep and his supporters](https://stallman-report.org/). Not a great organization to trust with... well, anything, really.

For whichever reason, EUPL being a proper strong copyleft license made FSF quite unhappy, leading it to deny compatibility with GPL: [lol](https://interoperable-europe.ec.europa.eu/collection/eupl/discussion/how-does-fsf-considers-eupl), [lmao](https://interoperable-europe.ec.europa.eu/collection/eupl/discussion/fsf-still-marks-eupl-incompatiple-gpl).

## EUPL and copyleft

As mentioned in the section on interoperability, EUPL is not "viral": having a dependency on EUPL library does not require relicensing, as only the dependency is EUPL-licensed. That's considered "weak" copyleft, as opposed to "strong" (viral) copyleft. This makes it practical to write and distribute EUPL-licensed libraries.

A common confusion about EUPL has to do with its compatibility clause. This confusion is [further propagated by FSF](https://www.gnu.org/licenses/license-list.en.html#EUPL-1.2), claiming it's possible to "relicense" EUPL works. This kind of "legal gotcha" is proudly displayed on GNU website still, but [it's bullshit](https://interoperable-europe.ec.europa.eu/collection/eupl/how-use-eupl): the original work stays under EUPL always. Combined work *can* be distributed under compatible license terms, *if* EUPL's terms conflict with the compatible license. This is actually clarified in [introduction to EUPL](https://interoperable-europe.ec.europa.eu/collection/eupl/introduction-eupl-licence).

This is tricky, so an example would help. Common example is that it's possible to "relicense" the work to `MPL-2.0`, by including some EUPL code directly into the `MPL-2.0` application code. But: `MPL-2.0` *does not conflict* with EUPL. MPL is "weaker" and requires less guarantees, but it doesn't *forbid* placing additional ones. EUPL is explicitly compatible with MPL, and it places *additional* guarantees: publishing source code and covering SaaS. So: the "entire work" is `MPL-2.0`, majority of code is also `MPL-2.0`, but there's a bit of EUPL code that requires the source code of the EUPL part to be distributed *always*, including with SaaS.

If you are confused, you are not alone! Copyright is very tricky around "entire work" part. The license for the "entire work" isn't necessarily the same as of its components; but components are still licensed as they originally are, and so their obligations need to be met in full. If you still care, track license provenance with [REUSE](https://reuse.software/), it will save you from a lot of headaches.

Also, let us emphasize: source code of EUPL-licensed parts needs to be distributed *always*, including with SaaS. EUPL defines network access as "distribution/communication", so accessing a service that is based on EUPL code means source code needs to be provided. We have AGPLv3 at home, but better!

## Two licenses in a trench coat

Let's quickly summarize, because that was a lot of legalese bullshit.

EUPL can be used for libraries, and for applications. And in practice, it works differently:

- *For applications*, EUPL is analogous to AGPLv3: usage over the network requires disclosing source code. This is what makes EUPL toxic to Google, and what makes it reciprocal.
- *For libraries*, EUPL is analogous to `LGPL-2.0` *with static linking exception*, and so can be served with a notice and link to the library's source code. However, if the library is *modified*, the modifications need to be provided, even over the network. This makes patching libraries without contributing back to upstream impractical, and makes it reciprocal.

Actually, while writing this blost, we [found](https://interoperable-europe.ec.europa.eu/collection/eupl/how-use-eupl#:~:text=Law%2E-,The%20EUPL%20is,Work%2E) an absolutely delightful quote from the EUPL FAQ, which we'll present in full:

> The EUPL is a "software license" by design, but it cover "the Work" and what could be considered as its components or derivatives:  documentation, ancillary data or even hardware in case it includes the Work.

*Damn.*

## Small things to like about EUPL

Okay, there's a lot, so time for the lightning round.

[EUPL text](https://interoperable-europe.ec.europa.eu/sites/default/files/custom-page/attachment/2020-03/EUPL-1.2%20EN.txt) is short and legible! Like, genuinely short and legible. As far as copyleft licenses go.

EUPL was created by EU lawyers, with EU law and court practices in mind. This gives a clear frame of reference (compared to "presumably-worldwide" of GPL), such as by [prohibiting "no liability"](https://interoperable-europe.ec.europa.eu/collection/eupl/how-use-eupl#:~:text=Liability,-for):

> Licensors must be particularly attentive to physical risks (i.e. software driving a vehicle autonomously) or moral risks (i.e. in the case where their AI chatbot could encourage a person to commit suicide).

Yum!

EUPL *is* EU law. [Quite literally](https://interoperable-europe.ec.europa.eu/collection/eupl/how-use-eupl#:~:text=competent%2E-,According,country%2E): EUPL is to be treated by EU law by the country of residence, with fallback to Belgium if Licensor is outside of EU.

EUPL has [built-in DCO](https://interoperable-europe.ec.europa.eu/collection/eupl/news/eupl-includes-dco-why).

## Should you?

Idk we're not a lawyer, we just love anal, and we find EUPL neat and nerdy to talk about.

In practical terms: EUPL is quite nice. If you want to be more hipster, could use [EUPL with custom clauses](https://interoperable-europe.ec.europa.eu/collection/eupl/how-use-eupl#:~:text=But%20you%20may%20add%20complementary%20agreements%20to%20the%20EUPL%20in%20so%20far%20they%20are%20consistent%20with%20the%20Licence%20%28article%209%20states%29%2E), e.g. to forbid genAI training (lol, as if; run [iocaine](https://iocaine.madhouse-project.org/)).

But also, go join your local tech union, find a local queer hackerspace, pester representatives to block genAI shit. Licenses are but a thin slice of the world, especially now; they just happen to have turned out to be a fun ADHD+autism+OCD special interest nerdsniped that this boy here was once into. There's a bunch of better activism you can do if you put your mind into it, so go do it!
