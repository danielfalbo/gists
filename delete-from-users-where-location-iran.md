https://gist.github.com/avestura/ce2aa6e55dad783b1aba946161d5fef4
DELETE FROM users WHERE location = 'IRAN';

https://web.archive.org/web/20250929120429/https://gist.github.com/avestura/ce2aa6e55dad783b1aba946161d5fef4

# `DELETE FROM users WHERE location = 'IRAN';`

Hi! I am an Iranian Software Engineer, and in this torn paper note, I want to talk about
some funny moments I had online related to the fact that I was spawned in this specific region of the world: Iran.

## Microsoft deleted my app, ignored my mails

Back when I was a student, I got access to the [Microsoft Imagine](https://imaginecup.microsoft.com/en-us), and as a result, I got 
access to the Microsoft Store as a developer. This inspired me write one of my open-source projects called [EyesGuard](https://github.com/avestura/EyesGuard)
and publish it on Microsoft Store. However, one day, somebody told me that they can no longer find EyesGuard on the store.

I came to the realization that Microsoft deleted my app, my developer account, and all those comments on my app supporting me and suggesting
ideas on how to improve the program. I tried to contact the support and email whoever I could, but I was ghosted.
Nobody ever explained to me why, but I assume it's because of the sanctions.

## Notion wiped me out of existence

Notion is a great product, and it was the primary tool I used to manage my personal notes. Not until they suddenly decided to
wipe out every data related to the users residing in Iran. Hopefully, they actually responded to my support message:

<img width="408" height="398" alt="image" src="https://gist.github.com/user-attachments/assets/dae97147-1dce-4619-8e3a-91ea51d1a506" />

It was because of sanctions. However, they told me that they will not restore the data, even if I leave Iran someday:

<img width="429" height="675" alt="image" src="https://gist.github.com/user-attachments/assets/c934ce8b-ca83-471c-991a-269548a9e584" />

That said, I am very happy with my own self-hosted [Siyuan](https://github.com/siyuan-note/siyuan) now.

## Mike Cardwell kindly asked me to fuck off

I read hackernews on a daily basis and I visit lots of different websites regularly. I am almost always on my VPN as I am internally firewalled by 
the government and externally shooed because of the sanctions, so I am probably missing some of these heart-warming messages:

> Iranian IPs are blocked here, due to your decision to arm Russia with drones so that they can indiscriminately massacre civilians.

My VPN turned off, and opening https://www.grepular.com showed me this message. I actually do not blame the people who do this. I think there is
a fundamental misconception that people think because "Islamic Republic" has the word "Republic" in it, it must be a government of people in charge. That's not the case. I have yet to see anyone who actually supports Russian aggression in my real life in Iran.
Funny enough, Iran's history is full of backstabs by the Russian government.

I tried contacting the author by sending this email:
```
Hi Mark,

I hope this message finds you well.

While browsing HackerNews, I came across your website but was greeted with this message:

> Iranian IPs are blocked here, due to your decision to arm Russia with drones so that they can indiscriminately massacre civilians.

I wanted to clarify that the decision to support Russia does not represent the Iranian people. That "your decision" refers to the regime, a theocratic minority that rules Iran without democratic legitimacy. The people of Iran have long protested and revolted against this regime, but unfortunately, they face brutal suppression while unarmed.

In my experience, most Iranians around me, including myself, stand firmly with Ukraine and against Russian aggression.

I’m not asking you to reconsider the IP restriction, you have your reasons and I respect that. I simply wanted to share this perspective and express my solidarity with Ukraine.

Slava Ukraini!

Best regards,
Avestura
```

I got no replies from them, and I actually didn't expect one.

## GitHub freaked me out

<img width="3351" height="321" alt="image" src="https://gist.github.com/user-attachments/assets/641fc0ea-69f7-4fcd-acdd-0e51fc805f85" />

I woke up to the news that GitHub has removed the access of Iranians to their private repositories. Well, that was not good. I tried to launch my own self-hosted instance of Gitea to reduce the damage. However, later, GitHub announced that [github is now available in Iran](https://github.blog/news-insights/policy-news-and-insights/advancing-developer-freedom-github-is-fully-available-in-iran/) by securing a license from the US government, and we're now good. You see? The weather is good, the birds are singing, GitHub is free again. Fantastic!

## GitLab freaked me out

Similarly, GitLab banned every account that once accessed from an Iranian IP, however, to this day, they never lifted the
ban, even on public repositories. I guess they couldn't secure a license from the US government, or they simply never cared.
Good luck to them in either case, though. GitLab is an amazing software. One can always self-host it.

## List goes on

The list goes on, and almost all of the services you probabelly heard of is banned here: Cloud platforms (AWS, GCP, Azure, ...),
Educational platforms (coursera, udemy, etc), Payment software (stripe, paypal, ...).

## Lessons Learned for me

I don't think any of these companies have bad intentions towards any group of people. They are a business after all. They don't hate their customers; they are just playing the game, and the game has such rules.
But if someday some law or government forces me to prevent my services from a group, I'll think twice before writing those `if` statements. I'll try to have more empathy. People behind those screens are more important than just some rows in my tables.


## Footnote

> [!IMPORTANT]
> In this text, I am NOT asking for the removal of
> the sanctions targeted at the Islamic Republic of Iran. I am merely remembering some moments on top of my head.
> For the record, I do not support
> the actions of the Islamic Republic, and on the contrary, I am in favor of the movements that release the people from such
> a mafia-like cult ruling a country with thousands of years of history.
> The actions of the group in charge of Iran are not defensible, and as a matter of fact,
> the people of Iran are the first layer of victims. Some examples are listed [here](https://en.wikipedia.org/wiki/Human_rights_in_the_Islamic_Republic_of_Iran).
> I especially feel it differently, as regime thugs put a gun to the throat of a dear person to me, and threatened to kill him if he showed up in
> [protests](https://en.wikipedia.org/wiki/Mahsa_Amini_protests).


---

By the way, did you know you could return `451 Unavailable For Legal Reasons` instead of `403 Forbidden` when you're going to ban me next time?
