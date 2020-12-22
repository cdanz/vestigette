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
			<h1>Vestigette</h1>
			<div><a href="index.php?arg=<?php echo $_SESSION['currentArg'];?>">Return to Previous</a></div>
			<div><a href="Explore.php?arg=<?php echo $_SESSION['currentArg'];?>">Explore</a></div>
			<div><a href="Profile.php?arg=<?php echo $_SESSION['currentArg'];?>">Profile</a></div>
			<div><a href="<?php echo ($profile) ? 'logout' : 'login'; ?>.php?arg=<?php echo $_SESSION['currentArg'];?>"><?php echo ($profile) ? 'Logout' : 'Login'; ?></a></div> 
		</div>

		<div id="because" class="accordion container">
			<h2>About</h2>

			<div class="panel" data-container-id="because">
				<br>
				<p>Vestigette is the world's first consensus building platform. Discussion as a single collective ongoing project.</p>
				<br>
				<p>Vestigette produces a model of our discourse. A map to study, use, and improve. Passively participated in, resistant to trolls, and anonymous - bizarro social media.</p>
				<br>
				<p><strong>Why?</strong></p>
				<br>
				<p>There is a science fiction trope where a great technological power is discovered, but rather than telling the world the protagonist wisely decides to hide it away or even destroy it. It would be too great a risk to leave society to its own devices with it because society cannot be trusted to act responsibly. "Humanity is just not ready" - the lesson. But will humanity EVER be ready?</p>
				<br>
				<p>Are we not the same, fundamentally flawed, creatures we have always been? Yes our technology advances but us?</p>
				<br>
				<p>This question should not depress us. We are not so bad. There is a great deal of good to be found in us. There is a great deal of wisdom. There is a great deal of sense. But there is an impression that too often what is right is not what rises to the top. The question Vestigette aims to answer is: How do we more readily identify good sense to outline the common wisdom?</p>
				<br>
				<p>Our most prominent systems of communicating today are based on what most piques interest. That is not a good system. What would be? Vestigette is an attempt at collective decision making. My attempt to determine precisely: what is what.</p>
				</p>
				<br>
				<p><strong>What does "Vestigette" mean?</strong></p>
				<br>
				<p>Vestigette is a made up word. Taken from the latin "vestigium" - to track, trace, or mark,  "Vestige" is its most familiar English descendant. Notable because the word "vestige" is so inextricably of the past. There is not a more intentional, affirmative, present form of the word. Vestigette is that present tense alternative - that marker left behind with the intention of aiding those that follow. Its suffix, "-gette", invokes suffrage because, in adding clarity and context, Vestigette also aims to expand the voice of the underrepresented.</p>
				<br>
			</div>
		</div>

		<div id="rebuttal" class="accordion container">
			<h2>How-To</h2>
			<div class="panel" data-container-id="because">
				<br>
				<p style="white-space:normal;">Vestigette is an abstraction of common argument mapping techniques. Each argument is an assertion, phrased as its proponents prefer best. Arguments are linked together in 3 different ways: those that (1) precede - <span style="color: var(--cddbBlue); font-weight:bold;">Because</span>, (2) follow - <span style="color: var(--cddbGreen); font-weight:bold;">Therefore</span>, or (3) refute - <span style="color: var(--cddbRed); font-weight:bold;">Rebuttal</span>.
				<br>
				<br>
				Users aim to develop and track their own personal line of reasoning around any given topic within the Vestigette framework. To ensure their reasoning is optimally compelling while consistent with principles and beliefs previously tracked involves continuous reconsideration and fine-tuning.
				<br>
				<br>
				Accept or Reject<br>
				&emsp;Options if you Accept:<br>
				&emsp;&emsp;1. Weigh in, distributing proportional significance to arguments connected as <span style="color: var(--cddbBlue); font-weight:bold;">Because</span> arguments<br>
				&emsp;&emsp;&emsp;1a - Connect an argument not yet associated<br>
				&emsp;&emsp;2. Weigh in, distributing proportional significance to arguments connected as <span style="color: var(--cddbGreen); font-weight:bold;">Therefore</span> arguments<br>
				&emsp;&emsp;&emsp;2a - Connect an argument not yet associated<br>
				&emsp;&emsp;3. Vote on the best phrasing of the argument<br>
				&emsp;&emsp;&emsp;3a - Endorse a pre-existing phrasing<br>
				&emsp;&emsp;&emsp;3b - Add your own preferred phrasing to endorse<br>
				&emsp;&emsp;4. Weigh in on the best explication (link to content)<br>
				&emsp;&emsp;&emsp;4a - Endorse a pre-existing submission<br>
				&emsp;&emsp;&emsp;4b - Add your own preferred and endorse<br>
				&emsp;Option if you Reject:<br>
				&emsp;&emsp;1. Weigh in, distributing proportional significance to arguments connected as <span style="color: var(--cddbRed); font-weight:bold;">Rebuttal</span> arguments<br>
				<br>
				<br>
				Users interact by first choosing to "Accept" or "Reject" an argument. Accepting an argument gives a user the right to endorse which arguments should be linked as its <span style="color: var(--cddbBlue); font-weight:bold;">Because</span> or <span style="color: var(--cddbGreen); font-weight:bold;">Therefore</span> types. Users that accept an argument also have the right to improve the argument by choosing a Phrasing (&#x270e;) that better puts the argument forth or to promote a preferred Explication (&#x2318;) - a url link to any kind of content: news article, academic paper, explainer video, meme - that may better expand upon or exemplify the point the argument makes. Rejecting the argument, on the other hand, gives those users who are its opponents the right to prioritize arguments linked to it in order to refute it as its <span style="color: var(--cddbRed); font-weight:bold;">Rebuttal</span> types.
				<br>
				<br>
				The 3 types of links from the primary argument at hand to others are applied with a weight. Each user can give their full weight to a single argument of any type they have rights to, or distribute weight proportionally among many. The circular chart to the left of each argument becomes a button upon choosing to weigh in. Apply weight to arguments of your choosing by clicking the circle button to its left. Each click gives an argument more weight relative to the others. Once satisfied with the weighting, submit your endorsement and add to the collective whole.</p>
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
				<p>Vestigette was created by Craig Danz of Seattle, WA, U.S.A. Copyright 2015</p>
				<br>
			</div>
		</div>

	</body>
</html>