//
//  ViewController.m
//  jingle
//
//  Created by 猪猪 on 2016/12/27.
//  Copyright © 2016年 猪猪. All rights reserved.
//

#import "ViewController.h"
#import "RTCPeerConnection.h"
#import "RTCPeerConnectionInterface.h"
#import "RTCICEServer.h"
#import "RTCPeerConnectionFactory.h"
#import "RTCPair.h"
#import "RTCMediaConstraints.h"
#import "RTCSessionDescription.h"
#import "RTCSessionDescriptionDelegate.h"

#define YOUR_SERVER @"stun:stun.example.org"

#define USERNAME_OR_EMPTY_STRING  @""
#define PASSWORD_OR_EMPTY_STRING  @""

@interface ViewController ()<RTCPeerConnectionDelegate,RTCSessionDescriptionDelegate>{
    RTCConfiguration *configure;
    RTCPeerConnection *pc;
    
    
    
    //remote
    
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)connectionInit {
    
    RTCICEServer *iceServer = [[RTCICEServer alloc] initWithURI:[NSURL URLWithString:YOUR_SERVER] username:USERNAME_OR_EMPTY_STRING
                                                       password:PASSWORD_OR_EMPTY_STRING];
    
    RTCPeerConnectionFactory *pcFactory = [[RTCPeerConnectionFactory alloc] init];
    RTCPeerConnection *peerConnection = [pcFactory peerConnectionWithICEServers:iceServer
                                                                    constraints:nil delegate:self];
    pc = peerConnection;
    
    
//    configure = [[RTCConfiguration alloc] init];
//    configure.iceServers = @[@{
//            @"url": @"stun:stun.example.org"}];
//    
//    [pc setConfiguration:configure];
    pc.delegate = self;
    //发送offer
    RTCMediaConstraints *constraints = [[RTCMediaConstraints alloc] initWithMandatoryConstraints:@[ [[RTCPair alloc] initWithKey:@"OfferToReceiveAudio" value:@"true"],[[RTCPair alloc] initWithKey:@"OfferToReceiveVideo" value:@"true"]]optionalConstraints: nil];
    [pc createOfferWithDelegate:self constraints:constraints];

}

#pragma mark RTCPeerConnectionDelegate
// Triggered when the SignalingState changed.
- (void)peerConnection:(RTCPeerConnection *)peerConnection
 signalingStateChanged:(RTCSignalingState)stateChanged {
    
}

// Triggered when media is received on a new stream from remote peer.
- (void)peerConnection:(RTCPeerConnection *)peerConnection
           addedStream:(RTCMediaStream *)stream {
}

// Triggered when a remote peer close a stream.
- (void)peerConnection:(RTCPeerConnection *)peerConnection
         removedStream:(RTCMediaStream *)stream {
    
}

// Triggered when renegotiation is needed, for example the ICE has restarted.
- (void)peerConnectionOnRenegotiationNeeded:(RTCPeerConnection *)peerConnection {
   
}

// Called any time the ICEConnectionState changes.
- (void)peerConnection:(RTCPeerConnection *)peerConnection
  iceConnectionChanged:(RTCICEConnectionState)newState {
    
}

// Called any time the ICEGatheringState changes.
- (void)peerConnection:(RTCPeerConnection *)peerConnection
   iceGatheringChanged:(RTCICEGatheringState)newState {
    
}

// New Ice candidate have been found.
- (void)peerConnection:(RTCPeerConnection *)peerConnection
       gotICECandidate:(RTCICECandidate *)candidate {
    if (candidate) {
        
    }
}

// New data channel has been opened.
- (void)peerConnection:(RTCPeerConnection*)peerConnection
    didOpenDataChannel:(RTCDataChannel*)dataChannel {
    
}




#pragma mark RTCSessionDescriptionDelegate

// Called when creating a session.
- (void)peerConnection:(RTCPeerConnection *)peerConnection
didCreateSessionDescription:(RTCSessionDescription *)sdp
                 error:(NSError *)error {
    if(peerConnection != pc) {
        RTCSessionDescription *remoteDesc = [[RTCSessionDescription alloc] initWithType:@"answer" sdp:sdp.description];
        [peerConnection setRemoteDescriptionWithDelegate:self sessionDescription:remoteDesc];
    } else {
        [pc setLocalDescriptionWithDelegate:self sessionDescription:sdp];

    }
}

// Called when setting a local or remote description.
- (void)peerConnection:(RTCPeerConnection *)peerConnection
didSetSessionDescriptionWithError:(NSError *)error {
    if (peerConnection.signalingState == RTCSignalingHaveLocalOffer) {
        // 通过Signaling Channel发送Offer之类的信息
    } else if (peerConnection.signalingState == RTCSignalingHaveRemoteOffer) {
        
    }
}
@end
