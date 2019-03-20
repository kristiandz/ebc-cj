#include emz\_hud_util;

oldNotifyMessage( titleText, notifyText, iconName, glowColor, sound, duration )
{
	notifyData = spawnstruct();
	
	notifyData.titleText = titleText;
	notifyData.notifyText = notifyText;
	notifyData.iconName = iconName;
	notifyData.glowColor = glowColor;
	notifyData.sound = sound;
	notifyData.duration = duration;
	
	notifyMessage( notifyData );
}

notifyMessage( notifyData )
{
	self endon ( "death" );
	self endon ( "disconnect" );
	
	if ( !self.doingNotify )
	{
		self thread showNotifyMessage( notifyData );
		return;
	}
	
	self.notifyQueue[ self.notifyQueue.size ] = notifyData;
}

showNotifyMessage( notifyData )
{
	self endon("disconnect");
	
	self.doingNotify = true;

	waitRequireVisibility( 0 );

	if ( isDefined( notifyData.duration ) )
		duration = notifyData.duration;
	else
		duration = 4.0;
	
	self thread resetOnCancel();

	if ( isDefined( notifyData.sound ) )
		self playLocalSound( notifyData.sound );

	if ( isDefined( notifyData.leaderSound ) )
		self maps\mp\gametypes\_globallogic::leaderDialogOnPlayer( notifyData.leaderSound );
	
	if ( isDefined( notifyData.glowColor ) )
		glowColor = notifyData.glowColor;
	else
		glowColor = (0.3, 0.6, 0.3);

	anchorElem = self.notifyTitle;

	if ( isDefined( notifyData.titleText ) )
	{
		if ( isDefined( notifyData.titleLabel ) )
			self.notifyTitle.label = notifyData.titleLabel;
		else
			self.notifyTitle.label = &"";
			if ( isDefined( notifyData.titleLabel ) && !isDefined( notifyData.titleIsString ) )
			self.notifyTitle setValue( notifyData.titleText );
		else
			self.notifyTitle setText( notifyData.titleText );
		self.notifyTitle setPulseFX( 100, int(duration*1000), 1000 );
		self.notifyTitle.glowColor = glowColor;	
		self.notifyTitle.alpha = 1;
	}

	if ( isDefined( notifyData.notifyText ) )
	{
		if ( isDefined( notifyData.textLabel ) )
			self.notifyText.label = notifyData.textLabel;
		else
			self.notifyText.label = &"";
		if ( isDefined( notifyData.textLabel ) && !isDefined( notifyData.textIsString ) )
			self.notifyText setValue( notifyData.notifyText );
		else
			self.notifyText setText( notifyData.notifyText );
		self.notifyText setPulseFX( 100, int(duration*1000), 1000 );
		self.notifyText.glowColor = glowColor;	
		self.notifyText.alpha = 1;
		anchorElem = self.notifyText;
	}

	if ( isDefined( notifyData.notifyText2 ) )
	{
		self.notifyText2 setParent( anchorElem );
		
		if ( isDefined( notifyData.text2Label ) )
			self.notifyText2.label = notifyData.text2Label;
		else
			self.notifyText2.label = &"";
			
		self.notifyText2 setText( notifyData.notifyText2 );
		self.notifyText2 setPulseFX( 100, int(duration*1000), 1000 );
		self.notifyText2.glowColor = glowColor;	
		self.notifyText2.alpha = 1;
		anchorElem = self.notifyText2;
	}

	if ( isDefined( notifyData.iconName ) )
	{
		self.notifyIcon setParent( anchorElem );
		self.notifyIcon setShader( notifyData.iconName, 60, 60 );
		self.notifyIcon.alpha = 0;
		self.notifyIcon fadeOverTime( 1.0 );
		self.notifyIcon.alpha = 1;
		
		waitRequireVisibility( duration );

		self.notifyIcon fadeOverTime( 0.75 );
		self.notifyIcon.alpha = 0;
	}
	else
	{
		waitRequireVisibility( duration );
	}

	self notify ( "notifyMessageDone" );
	self.doingNotify = false;

	if ( self.notifyQueue.size > 0 )
	{
		nextNotifyData = self.notifyQueue[0];
		
		newQueue = [];
		for ( i = 1; i < self.notifyQueue.size; i++ )
			self.notifyQueue[i-1] = self.notifyQueue[i];
		self.notifyQueue[i-1] = undefined;
		
		self thread showNotifyMessage( nextNotifyData );
	}
}

waitRequireVisibility( waitTime )
{
	interval = .05;
	
	while ( waitTime > 0 ){
		wait interval;
		waitTime -= interval;
	}
}

resetOnCancel()
{
	self notify ( "resetOnCancel" );
	self endon ( "resetOnCancel" );
	self endon ( "notifyMessageDone" );
	self endon ( "disconnect" );

	level waittill ( "cancel_notify" );
	
	self.notifyTitle.alpha = 0;
	self.notifyText.alpha = 0;
	self.notifyIcon.alpha = 0;
	self.doingNotify = false;
}