import React from 'react';
import styled from 'styled-components';

const AuthContainerWrapper = styled.div`
  display: flex;
  background-color: white;
  flex-direction: column;
  width: 100vw;
  height: 90vh;
`;

const MainContainer = styled.div`
  display: flex;
  width: 100%;
  height: 100%;

  flex-direction: column;
  justify-content: space-evenly;
  align-items: center;

  font-family: 'Roboto', sans-serif;
  font-size: 20px;
  font-style: normal;
  font-weight: 400;
  line-height: 24px;
  letter-spacing: 0.15px;
`;

export const AuthContainer = (): JSX.Element => {
  return (
    <AuthContainerWrapper>
      <MainContainer>
        <h2>Sign in to start</h2>
        <a href="https://slack.com/oauth/authorize?client_id=340624728833.3331468548978&scope=users.profile%3Awrite%2Cusers.profile%3Aread%2Cteam%3Aread">
          <img
            alt="Add to Slack"
            height="40"
            width="139"
            src="https://platform.slack-edge.com/img/add_to_slack.png"
            srcSet="https://platform.slack-edge.com/img/add_to_slack.png 1x, https://platform.slack-edge.com/img/add_to_slack@2x.png 2x"
          />
        </a>
      </MainContainer>
    </AuthContainerWrapper>
  );
};
