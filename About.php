<?php 
session_start();
$_SESSION['currentArg'] = intval($_GET["arg"]); 
$baseURL = "/index.php";
$arg = isset($_SESSION['currentArg']) ? $_SESSION['currentArg'] : null;
$profile = isset($_SESSION['profile']) ? $_SESSION['profile'] : null;
?>
<!DOCTYPE html>
<html>
	<head>
		<title>Vestigette - About</title>
		<meta charset="utf-8"/>
		<meta name="keywords" content="argument, dialectic, reasoning, anti-troll, discussion, debate, assertion network, dialogue, public forum, town square, consensus building, diliberation chamber, diliberative body, dynamic polling, self-guided polling, opposition research, best reason why, best reason not"/>
		<meta name="copyright" content="Copyright 2015 Craig Danz Seattle, WA USA" />
		<meta name="robots" content="follow" />
		<meta name="viewport" content="width=device-width, initial-scale=1.0" />
		<link rel="stylesheet" href="style_vestigette.css" />
		<script language="javascript" src="script_vestigette.js"></script>
		<script language="javascript">
			let arg = <?php echo isset($arg) ? $arg : 'undefined'; ?>,
				profile = <?php echo isset($profile) ? $profile : 'undefined'; ?>,
				opinion = <?php echo isset($opinion) ? $opinion : 'undefined'; ?>,
				assoc = <?php echo isset($assocWeights) ? "JSON.parse(" + $assocWeights + ")" : 'undefined'; ?>, //not used
				because = <?php echo json_encode($because); ?>,
				therefore = <?php echo json_encode($therefore); ?>,
				rebuttal = <?php echo json_encode($rebuttal); ?>;
		</script>
	</head>
	<body>

		<div id="mastHead" class="container">
			<h1><a href="index.php?arg=<?php echo $_SESSION['currentArg'];?>">Vestigette</a></h1>
			<div>
				<a href="About.php?arg=<?php echo $_SESSION['currentArg'];?>"><span style="text-decoration: underline;">About</span></a>
				<a href="Explore.php?arg=<?php echo $_SESSION['currentArg'];?>">Explore</a>
				<a href="Profile.php?arg=<?php echo $_SESSION['currentArg'];?>">Profile</a>
				<a href="<?php echo ($profile) ? 'logout' : 'login'; ?>.php?arg=<?php echo $_SESSION['currentArg'];?>"><?php echo ($profile) ? 'Logout' : 'Login'; ?></a>
				<a href="#" class="closenav" onclick="closeNav()">&times;</a>
			</div> 
			
			<a href="#" class="opennav" onclick="openNav()">&equiv;</a>
		</div>
		<div id="because" class="accordion container">
			<h2>About</h2>

			<div class="panel" data-container-id="because">
				<br>
				<p>Vestigette is the world's first consensus building platform. Discussion as a single, collective, ongoing project.</p>
				<br>
				<p>Vestigette produces a model of our discourse. A map to study, use, and improve. Passively participated in, resistant to trolls, and anonymous - bizarro social media.</p>
				<br>
				<p><strong>Why?</strong></p>
				<br>
				<p>Consider the sci-fi trope: a powerful technology is discovered, however, instead of sharing it with the world, the hero decides it must be destroyed. Humanity is simply not mature enough to be trusted with such power.
				<br><br>
				The thing is - who is to say humanity will ever truly mature any further? And who is to say we can be trusted with the technologies humanity has already unleashed? How do we best play the hand we've been dealt?
				<br><br>
				A reason for hope is we are not all bad. There is a great deal of good to be found amongst us. There is a great deal of wisdom. There is a great deal of sense. But there also is an impression that too often what is right is not what's brought to the fore. The question Vestigette aims to answer then is: how do we access the best of humanity for guidance?
				<br><br>
				Through a dogged pursuit of fair representation, it is the mission of Vestigette to conduct the most extensive exercise in open inquiry in history.</p>
				<br>
				<p><strong>What does "Vestigette" mean?</strong></p>
				<br>
				<p>Vestigette is a made-up word. From the Latin "vestigium" - to track, trace, or mark. The most common descendant "Vestige" is notable because it is so inextricably of the past. There is not a more intentional, affirmative, present form of the word. Vestigette means to lay down a marker with the intention of aiding those that follow. The suffix, "-gette", invokes suffrage because Vestigette aims to add clarity and context to our dialogue by giving voice to the underrepresented.</p>
				<br>
			</div>
		</div>

		<div id="rebuttal" class="accordion container">
			<h2>How-To</h2>
			<div class="panel" data-container-id="because">
				<br>
				<p style="white-space:normal;">Vestigette is an abstraction of common argument mapping techniques. Each argument is an assertion - phrased as its proponents prefer best. Arguments are linked together in 3 different ways: those that (1) precede - <span style="color: var(--cddbBlue); font-weight:bold;">Because</span>, (2) follow - <span style="color: var(--cddbGreen); font-weight:bold;">Therefore</span>, or (3) refute - <span style="color: var(--cddbRed); font-weight:bold;">Rebuttal</span>.
				<br>
				<br>
				<span style="color: var(--cddbBlue); text-decoration: underline;"><a href="https://youtu.be/gSlucDTMsmA">30 Second Video Tutorial</a></span>
				<br>
				<br>
				Users develop and track their own personal lines of reasoning within the Vestigette framework. Maintaining a line of reasoning that is optimally compelling while consistent with principles and beliefs previously tracked involves continuous reconsideration and fine-tuning. This collective effort produces a map of both the common wisdom and where/how it deviates.
				<br>
				<br>
				Users interact with an argument first by choosing to "Accept" or "Reject". Accepting an argument gives a user the right to endorse which other arguments should be linked as its <span style="color: var(--cddbBlue); font-weight:bold;">Because</span> or <span style="color: var(--cddbGreen); font-weight:bold;">Therefore</span> types. Users that accept an argument also improve the argument by deciding a <span style="color: var(--cddbBlack); font-weight:bold;">Phrasing (&#x270e;)</span> that better puts the argument forth and promote a preferred <span style="color: var(--cddbBlack); font-weight:bold;">Explication (&#x2318;)</span> - a link to any kind of content (news article, academic paper, explainer video, meme) that better exemplifies, expands upon or gives evidence toward the point of the the argument. Rejecting the argument gives opponents the right to prioritize arguments linked to refute it as its <span style="color: var(--cddbRed); font-weight:bold;">Rebuttal</span> types.
				<br>
				<br>
				Start with <span style="color: var(--cddbGreen); font-weight:bold;">Accept</span> or <span style="color: var(--cddbRed); font-weight:bold;">Reject</span><br>
				&emsp;&#x2022;  If you <span style="color: var(--cddbGreen); font-weight:bold;">Accept</span>:<br>
				&emsp;&emsp;&#x2022;  1. Weigh in, distributing proportional significance to arguments connected as either <span style="color: var(--cddbBlue); font-weight:bold;">Because</span> or <span style="color: var(--cddbGreen); font-weight:bold;">Therefore</span> arguments<br>
				&emsp;&emsp;&#x2022;  2. Vote on the best <span style="color: var(--cddbBlack); font-weight:bold;">Phrasing</span> of the argument<br>
				&emsp;&emsp;&#x2022;  3. Vote on the best <span style="color: var(--cddbBlack); font-weight:bold;">Explication</span> (link to content)<br>
				&emsp;&#x2022;  If you <span style="color: var(--cddbRed); font-weight:bold;">Reject</span>:<br>
				&emsp;&emsp;&#x2022;  1. Weigh in, distributing proportional significance to arguments connected as <span style="color: var(--cddbRed); font-weight:bold;">Rebuttal</span> arguments<br>
				<br>
				<br>
				The links from the argument at hand to others are applied with a <span style="font-weight:bold;">weight</span>. Each user can give their full <span style="font-weight:bold;">weight</span> to a single argument of any type they have rights to, or distribute <span style="font-weight:bold;">weight</span> proportionally among many. The circular chart to the left of each argument becomes a button upon choosing to <span style="font-weight:bold;">weigh in</span>. Apply <span style="font-weight:bold;">weight</span> to arguments of your choosing by clicking the circle button to its left. Each click gives an argument more <span style="font-weight:bold;">weight</span> relative to the others. Once satisfied, submit your endorsement and add to the collective whole.</p>
				<br>
			</div>
		</div> 

		<div id="therefore" class="accordion container">
			<h2>Contribute</h2>
			<div class="panel" data-container-id="because">
				<br>
				<p>Vestigette is in its inital development stage and self-funded. Software development guidance, legal assistance, financial support or general user feedback are all accepted graciously.</p>
				<br>
				<p>To request to become a beta user, email your request to <a href="mailto:craig@vestigette.org">craig@vestigette.org</a></p>
				<br>
			</div>
		</div>
		<div id="argument" class="accordion container">
			<div class="panel expanded" data-container-id="argument">
				<br>
				<p>Vestigette was created by Craig Danz of Seattle, WA, U.S.A. Copyright <?php echo date("Y"); ?></p>
				<a href="https://twitter.com/vestigette?ref_src=twsrc%5Etfw" class="twitter-follow-button" data-show-count="false">Follow @vestigette</a><script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>
				<br>
			</div>
		</div>

	</body>
</html>